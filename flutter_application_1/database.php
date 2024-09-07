<?php 
$hostName ="localhost";
$dbUser = "root";
$dbPassword = "";
$dbName = "flutter_app";
$conn = mysqli_connect($hostName, $dbUser, $dbPassword, $dbName);
if (!$conn){
    die("Something went wrong;");
}
?>