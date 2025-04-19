<?php
    header('Content-Type: application/json');
    ini_set('display_errors', 0);
    ini_set('log_errors', 1);
    error_reporting(E_ALL);

    // DB connection
    $host = "localhost";
    $user = "root";
    $pass = "";
    $db = "pifast"; 

    $conn = new mysqli($host, $user, $pass, $db);
    if ($conn->connect_error) {
        echo json_encode(['error' => 'Database connection failed']);
        exit;
    }

    // Fetch categories
    $sql = "SELECT * FROM categories";
    $result = $conn->query($sql);

    $categories = array();
    if ($result && $result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
            $categories[] = $row;
        }
    }

    echo json_encode($categories);
    $conn->close();
?>
