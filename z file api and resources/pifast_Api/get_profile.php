<?php
header('Content-Type: application/json');

// === Database Config ===
$host = 'localhost';
$user = 'root';
$pass = '';
$dbname = 'pifast';

// === Connect to DB ===
$conn = new mysqli($host, $user, $pass, $dbname);
if ($conn->connect_error) {
    echo json_encode(["status" => "error", "message" => "Connection failed: " . $conn->connect_error]);
    exit;
}

// === Get profile data (assuming single user with id = 1) ===
$sql = "SELECT name, email FROM users WHERE id = 1";
$result = $conn->query($sql);

if ($result && $result->num_rows > 0) {
    $row = $result->fetch_assoc();
    echo json_encode([
        "status" => "success",
        "name" => $row["name"],
        "email" => $row["email"]
    ]);
} else {
    echo json_encode([
        "status" => "error",
        "message" => "User not found"
    ]);
}

$conn->close();
?>
