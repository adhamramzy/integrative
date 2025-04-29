<?php
/**
 * QR Code Library Installer
 * 
 * This script downloads and installs the PHP QR Code library
 * for use with the Event Management System.
 */

// Set the desired library directory
$libDir = '../lib';
$qrCodeDir = $libDir . '/phpqrcode';

// Create directories if they don't exist
if (!file_exists($libDir)) {
    mkdir($libDir, 0755, true);
    echo "Created library directory: $libDir\n";
}

if (!file_exists($qrCodeDir)) {
    mkdir($qrCodeDir, 0755, true);
    echo "Created QR code library directory: $qrCodeDir\n";
}

// Download the library
$sourceUrl = 'https://github.com/chillerlan/php-qrcode/archive/master.zip';
$zipFile = $libDir . '/qrcode.zip';

echo "Downloading PHP QR Code library from $sourceUrl...\n";

// Try to use curl if available
if (function_exists('curl_init')) {
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $sourceUrl);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
    $data = curl_exec($ch);
    curl_close($ch);
    
    file_put_contents($zipFile, $data);
} 
// Otherwise use file_get_contents
else if (ini_get('allow_url_fopen')) {
    $data = file_get_contents($sourceUrl);
    file_put_contents($zipFile, $data);
} 
// If nothing works, provide instructions
else {
    echo "ERROR: Neither cURL nor file_get_contents is available. Please download the library manually:\n";
    echo "1. Download $sourceUrl\n";
    echo "2. Extract it and place the contents in $qrCodeDir\n";
    exit(1);
}

// Extract the zip file
echo "Extracting files...\n";
$zip = new ZipArchive;
if ($zip->open($zipFile) === TRUE) {
    $zip->extractTo($libDir);
    $zip->close();
    echo "Files extracted successfully.\n";
    
    // Copy or move files to the final destination
    $extractedDir = $libDir . '/php-qrcode-master';
    if (file_exists($extractedDir)) {
        // Copy contents to phpqrcode directory
        copyDirectory($extractedDir, $qrCodeDir);
        echo "Files copied to final destination.\n";
        
        // Clean up
        removeDirectory($extractedDir);
    } else {
        echo "WARNING: Could not find extracted directory.\n";
    }
} else {
    echo "ERROR: Could not extract the zip file.\n";
}

// Clean up the zip file
if (file_exists($zipFile)) {
    unlink($zipFile);
    echo "Temporary zip file removed.\n";
}

// Create a simple qrlib.php wrapper file for compatibility
$wrapperContent = <<<'EOD'
<?php
/**
 * QR Code Simple Wrapper
 * 
 * A compatibility wrapper for the chillerlan/php-qrcode library
 * to provide a simple interface similar to the older PHP QR Code library.
 */

// Import the real library
require_once __DIR__ . '/vendor/autoload.php';

use chillerlan\QRCode\{QRCode, QROptions};

// Define a wrapper class to mimic the old library's interface
class QRcode {
    /**
     * Generate QR code PNG image
     */
    public static function png($text, $outfile = null, $level = 0, $size = 3, $margin = 4) {
        // Set up options
        $options = new QROptions([
            'outputType' => QRCode::OUTPUT_IMAGE_PNG,
            'eccLevel' => $level,
            'scale' => $size,
            'margin' => $margin,
            'imageBase64' => false,
        ]);
        
        // Generate QR code
        $qrcode = new QRCode($options);
        
        if ($outfile !== null) {
            // Save to file
            file_put_contents($outfile, $qrcode->render($text));
        } else {
            // Output directly
            echo $qrcode->render($text);
        }
    }
}
EOD;

file_put_contents($qrCodeDir . '/qrlib.php', $wrapperContent);
echo "Created QR code wrapper file for compatibility.\n";

echo "Installation completed successfully!\n";
echo "You can now use the QR code library in your project.\n";

// Helper function to copy a directory recursively
function copyDirectory($source, $destination) {
    // Create destination directory if it doesn't exist
    if (!is_dir($destination)) {
        mkdir($destination, 0755, true);
    }
    
    // Open the source directory
    $dir = opendir($source);
    
    // Copy each file and subdirectory
    while (($file = readdir($dir)) !== false) {
        if ($file != '.' && $file != '..') {
            $sourcePath = $source . '/' . $file;
            $destPath = $destination . '/' . $file;
            
            if (is_dir($sourcePath)) {
                // Recursively copy subdirectories
                copyDirectory($sourcePath, $destPath);
            } else {
                // Copy files
                copy($sourcePath, $destPath);
            }
        }
    }
    
    closedir($dir);
}

// Helper function to remove a directory recursively
function removeDirectory($dir) {
    if (!file_exists($dir)) {
        return true;
    }
    
    if (!is_dir($dir)) {
        return unlink($dir);
    }
    
    foreach (scandir($dir) as $item) {
        if ($item == '.' || $item == '..') {
            continue;
        }
        
        if (!removeDirectory($dir . '/' . $item)) {
            return false;
        }
    }
    
    return rmdir($dir);
}
