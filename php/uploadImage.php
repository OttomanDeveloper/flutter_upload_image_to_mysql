<?php
include 'DatabaseConfig.php';

$conn = new mysqli($HostName, $HostUser, $HostPass, $DatabaseName);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$image = $_POST['image'];
$username = $_POST['username'];
$password = $_POST['password'];
$fullName = $_POST['fullName'];

$insert = $conn->query("INSERT INTO userData (username,fullName,password,image)VALUE('$username','$fullName','$password','$image')");

if ($insert) {
    echo json_encode('Success');
} else {
    echo json_encode('Error');
}
$conn->close();
return;
