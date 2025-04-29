<?php
/**
 * OTP (One-Time Password) API Endpoint
 * 
 * Handles generation and verification of OTPs for various functions in the system
 */

// Include configuration and helpers
require_once '../includes/config.php';

// Set content type to JSON
header('Content-Type: application/json');

// Create database table if it doesn't exist (first-time setup)
function createOtpTableIfNotExists() {
    $db = getDbConnection();
    $db->exec("
        CREATE TABLE IF NOT EXISTS otp (
            otp_id INT AUTO_INCREMENT PRIMARY KEY,
            user_id INT NOT NULL,
            otp_code VARCHAR(8) NOT NULL,
            purpose VARCHAR(50) NOT NULL,
            expires_at DATETIME NOT NULL,
            used BOOLEAN DEFAULT 0,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            INDEX (user_id),
            INDEX (otp_code)
        )
    ");
}

// Make sure the OTP table exists
createOtpTableIfNotExists();

// Generate a new OTP
function generateOtp($length = 6) {
    // Generate a random numeric OTP
    if ($length < 4) $length = 4; // Minimum length
    if ($length > 8) $length = 8; // Maximum length
    
    if (function_exists('random_int')) {
        // More secure method if available
        $otp = '';
        for ($i = 0; $i < $length; $i++) {
            $otp .= random_int(0, 9);
        }
        return $otp;
    } else {
        // Fallback method
        $multiplier = pow(10, $length - 1);
        return rand($multiplier, ($multiplier * 10) - 1);
    }
}

// Store OTP in database
function storeOtp($userId, $otpCode, $purpose, $expiryMinutes = 15) {
    $db = getDbConnection();
    
    // Calculate expiry time
    $expiresAt = date('Y-m-d H:i:s', strtotime("+{$expiryMinutes} minutes"));
    
    // Insert the OTP
    $stmt = $db->prepare("
        INSERT INTO otp (user_id, otp_code, purpose, expires_at)
        VALUES (?, ?, ?, ?)
    ");
    
    return $stmt->execute([$userId, $otpCode, $purpose, $expiresAt]);
}

// Verify an OTP
function verifyOtp($userId, $otpCode, $purpose) {
    $db = getDbConnection();
    
    // Find the OTP in the database
    $stmt = $db->prepare("
        SELECT * FROM otp 
        WHERE user_id = ? 
        AND otp_code = ? 
        AND purpose = ?
        AND expires_at > CURRENT_TIMESTAMP
        AND used = 0
        ORDER BY created_at DESC
        LIMIT 1
    ");
    
    $stmt->execute([$userId, $otpCode, $purpose]);
    $otp = $stmt->fetch();
    
    if ($otp) {
        // Mark the OTP as used
        $updateStmt = $db->prepare("
            UPDATE otp SET used = 1 
            WHERE otp_id = ?
        ");
        $updateStmt->execute([$otp['otp_id']]);
        
        return true;
    }
    
    return false;
}

// Clean up expired OTPs
function cleanupExpiredOtps() {
    $db = getDbConnection();
    
    // Delete OTPs that are expired for over 24 hours
    $stmt = $db->prepare("
        DELETE FROM otp
        WHERE expires_at < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 24 HOUR)
    ");
    
    return $stmt->execute();
}

// Run cleanup periodically (low chance on each request to avoid overhead)
if (rand(1, 100) <= 5) { // 5% chance
    cleanupExpiredOtps();
}

// POST request to generate an OTP
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Check if user is logged in
    if (!isLoggedIn()) {
        http_response_code(401);
        jsonResponse(['error' => 'Authentication required']);
    }
    
    // Get current user
    $user = getCurrentUser();
    
    // Get JSON data from request body
    $data = json_decode(file_get_contents('php://input'), true);
    
    // Validate required fields
    if (!isset($data['purpose'])) {
        http_response_code(400);
        jsonResponse(['error' => 'Purpose is required']);
    }
    
    $purpose = sanitizeInput($data['purpose']);
    $expiryMinutes = isset($data['expiry_minutes']) ? (int)$data['expiry_minutes'] : 15;
    
    // Limit expiry time between 5 minutes and 60 minutes
    if ($expiryMinutes < 5) $expiryMinutes = 5;
    if ($expiryMinutes > 60) $expiryMinutes = 60;
    
    // Valid purposes
    $validPurposes = ['account_verification', 'password_reset', 'login_verification', 'event_check_in'];
    
    if (!in_array($purpose, $validPurposes)) {
        http_response_code(400);
        jsonResponse(['error' => 'Invalid purpose']);
    }
    
    // Generate OTP
    $otpLength = isset($data['length']) ? (int)$data['length'] : 6;
    $otpCode = generateOtp($otpLength);
    
    // Store OTP
    $result = storeOtp($user['user_id'], $otpCode, $purpose, $expiryMinutes);
    
    if ($result) {
        // In a real system, you would send this via email or SMS
        // For demo purposes, we'll just return it
        jsonResponse([
            'success' => true,
            'message' => 'OTP generated successfully',
            'otp' => $otpCode, // In production, don't return this directly
            'expires_in' => $expiryMinutes . ' minutes'
        ]);
    } else {
        http_response_code(500);
        jsonResponse(['error' => 'Failed to generate OTP']);
    }
}

// PUT request to verify an OTP
if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
    // Check if user is logged in
    if (!isLoggedIn()) {
        http_response_code(401);
        jsonResponse(['error' => 'Authentication required']);
    }
    
    // Get current user
    $user = getCurrentUser();
    
    // Get JSON data from request body
    $data = json_decode(file_get_contents('php://input'), true);
    
    // Validate required fields
    if (!isset($data['otp']) || !isset($data['purpose'])) {
        http_response_code(400);
        jsonResponse(['error' => 'OTP and purpose are required']);
    }
    
    $otpCode = sanitizeInput($data['otp']);
    $purpose = sanitizeInput($data['purpose']);
    
    // Verify OTP
    $isValid = verifyOtp($user['user_id'], $otpCode, $purpose);
    
    if ($isValid) {
        // Log activity
        logActivity('verify_otp', "Verified OTP for purpose: $purpose", $user['user_id']);
        
        jsonResponse([
            'success' => true,
            'message' => 'OTP verified successfully'
        ]);
    } else {
        http_response_code(401);
        jsonResponse(['error' => 'Invalid or expired OTP']);
    }
}

// If we get here, it's an unsupported method
http_response_code(405);
jsonResponse(['error' => 'Method not allowed']);
