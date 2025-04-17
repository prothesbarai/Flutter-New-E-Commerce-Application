<?php
$host = 'localhost';
$user = 'root';
$pass = '';
$dbname = 'pifast';

$conn = new mysqli($host, $user, $pass, $dbname);
if ($conn->connect_error) {
    die(json_encode(["status" => "error", "message" => $conn->connect_error]));
}

$conn->query("
    CREATE TABLE IF NOT EXISTS users (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(100),
        email VARCHAR(100),
        city VARCHAR(100),
        shipping_address VARCHAR(255),
        billing_address VARCHAR(255)
    )
");

$name = $_POST['name'] ?? '';
$email = $_POST['email'] ?? '';
$city = $_POST['city'] ?? '';
$shipping_address = $_POST['shipping_address'] ?? '';
$billing_address = $_POST['billing_address'] ?? '';

$sql = "INSERT INTO users (name, email, city, shipping_address, billing_address) 
        VALUES ('$name', '$email', '$city', '$shipping_address', '$billing_address')";

if ($conn->query($sql) === TRUE) {
    echo json_encode(["status" => "success"]);
} else {
    echo json_encode(["status" => "error", "message" => $conn->error]);
}

$conn->close();
?>