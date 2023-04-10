<?php
include 'connection.php';
$id = $_GET['id'];

mysqli_query($con,"delete from blood_request_tb  where login_id='$id'");
echo "<script>alert('deleted')</script>";
echo "<script>window.location.href='users_view.php'</script>";



?>