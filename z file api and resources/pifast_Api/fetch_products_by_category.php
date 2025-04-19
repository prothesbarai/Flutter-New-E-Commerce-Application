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

    // Validate POST request
    if (!isset($_POST['table_name'])) {
        echo json_encode(['error' => 'Table name not provided']);
        exit;
    }

    $table = $_POST['table_name'];

    // Sanitize table name (avoid SQL injection)
    $table = preg_replace('/[^a-zA-Z0-9_]/', '', $table);

    // Run query
    $sql = "SELECT * FROM `$table`";
    $result = $conn->query($sql);

    $products = array();
    if ($result && $result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
            $products[] = $row;
        }
    }

    echo json_encode($products);
    $conn->close();
?>
