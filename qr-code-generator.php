<?php
/**
 * QR Code Generator API Endpoint
 * 
 * Generates QR codes for various purposes in the Event Management System
 */

// Include configuration and helpers
require_once '../includes/config.php';

// Set content type to JSON by default (will be changed for image output)
header('Content-Type: application/json');

// Check if user is logged in for protected operations
if (!isLoggedIn() && isset($_GET['type']) && $_GET['type'] !== 'public') {
    http_response_code(401);
    jsonResponse(['error' => 'Authentication required']);
}

// Get current user if logged in
$user = isLoggedIn() ? getCurrentUser() : null;

// Load PHP QR Code library
// Note: You need to download this library and place it in the specified directory
// https://github.com/chillerlan/php-qrcode
require_once '../lib/phpqrcode/qrlib.php';

// GET request to generate QR code
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Determine QR code type
    $type = isset($_GET['type']) ? sanitizeInput($_GET['type']) : 'text';
    
    // Get QR code data
    $data = isset($_GET['data']) ? $_GET['data'] : '';
    if (empty($data)) {
        http_response_code(400);
        jsonResponse(['error' => 'QR code data is required']);
    }
    
    // Sanitize data for all types except raw
    if ($type !== 'raw') {
        $data = sanitizeInput($data);
    }
    
    // Set QR code options
    $size = isset($_GET['size']) ? (int)$_GET['size'] : 5; // Default size (1-10)
    $margin = isset($_GET['margin']) ? (int)$_GET['margin'] : 2; // Default margin
    
    // Validate size
    if ($size < 1 || $size > 10) {
        $size = 5; // Reset to default if invalid
    }
    
    // Validate margin
    if ($margin < 0 || $margin > 5) {
        $margin = 2; // Reset to default if invalid
    }
    
    // Process based on type
    switch ($type) {
        case 'booking':
            // For booking QR codes (requires authentication)
            if (!$user) {
                http_response_code(401);
                jsonResponse(['error' => 'Authentication required for booking QR codes']);
            }
            
            // Verify the booking belongs to the user or user is admin/organizer
            $bookingId = (int)$data;
            $db = getDbConnection();
            
            $stmt = $db->prepare("
                SELECT b.*, e.title as event_title, e.organizer_id
                FROM bookings b
                JOIN tickets t ON b.ticket_id = t.ticket_id
                JOIN events e ON t.event_id = e.event_id
                WHERE b.booking_id = ?
            ");
            $stmt->execute([$bookingId]);
            $booking = $stmt->fetch();
            
            if (!$booking) {
                http_response_code(404);
                jsonResponse(['error' => 'Booking not found']);
            }
            
            $canAccess = ($booking['user_id'] == $user['user_id']) || 
                        ($user['role'] === 'admin') || 
                        ($booking['organizer_id'] == $user['user_id']);
            
            if (!$canAccess) {
                http_response_code(403);
                jsonResponse(['error' => 'You do not have permission to access this booking']);
            }
            
            // Generate QR code data for booking
            $qrData = $booking['qr_code'];
            break;
            
        case 'contact':
            // Generate a vCard QR code
            $name = isset($_GET['name']) ? sanitizeInput($_GET['name']) : '';
            $email = isset($_GET['email']) ? sanitizeInput($_GET['email']) : '';
            $phone = isset($_GET['phone']) ? sanitizeInput($_GET['phone']) : '';
            $org = isset($_GET['org']) ? sanitizeInput($_GET['org']) : '';
            
            $qrData = "BEGIN:VCARD\nVERSION:3.0\n";
            if ($name) $qrData .= "N:{$name}\nFN:{$name}\n";
            if ($email) $qrData .= "EMAIL:{$email}\n";
            if ($phone) $qrData .= "TEL:{$phone}\n";
            if ($org) $qrData .= "ORG:{$org}\n";
            $qrData .= "END:VCARD";
            break;
            
        case 'url':
            // URL QR code (validate URL)
            if (!filter_var($data, FILTER_VALIDATE_URL)) {
                http_response_code(400);
                jsonResponse(['error' => 'Invalid URL']);
            }
            $qrData = $data;
            break;
            
        case 'wifi':
            // WiFi network QR code
            $ssid = isset($_GET['ssid']) ? sanitizeInput($_GET['ssid']) : '';
            $password = isset($_GET['password']) ? sanitizeInput($_GET['password']) : '';
            $encryption = isset($_GET['encryption']) ? strtoupper(sanitizeInput($_GET['encryption'])) : 'WPA';
            
            if (empty($ssid)) {
                http_response_code(400);
                jsonResponse(['error' => 'SSID is required for WiFi QR code']);
            }
            
            // Valid encryption types
            if (!in_array($encryption, ['WEP', 'WPA', 'WPA2', 'WPA3', 'NONE'])) {
                $encryption = 'WPA';
            }
            
            $qrData = "WIFI:S:{$ssid};";
            if ($encryption !== 'NONE') $qrData .= "T:{$encryption};";
            if ($password) $qrData .= "P:{$password};";
            $qrData .= "H:false;;";
            break;
            
        case 'text':
        case 'raw':
        default:
            // Plain text QR code
            $qrData = $data;
            break;
    }
    
    // Set output format
    $format = isset($_GET['format']) ? strtolower(sanitizeInput($_GET['format'])) : 'png';
    
    if ($format === 'json') {
        // Return QR data as JSON
        jsonResponse([
            'success' => true,
            'data' => $qrData,
            'image_url' => getBaseUrl() . "/api/qrcode.php?type=raw&data=" . urlencode($qrData) . "&format=png"
        ]);
    } else {
        // Generate and output QR code image
        header('Content-Type: image/png');
        header('Cache-Control: max-age=86400'); // Cache for 24 hours
        
        // Options for QR code
        $options = [
            'yx' => ($size * 10), // Size multiplier
            'qt' => QR_ECLEVEL_M, // Error correction level (M = medium)
            'mz' => $margin // Margin
        ];
        
        // Generate QR code
        QRcode::png($qrData, null, $options['qt'], $options['yx'], $options['mz']);
        exit;
    }
}

// If we get here, it's an unsupported method
http_response_code(405);
jsonResponse(['error' => 'Method not allowed']);
