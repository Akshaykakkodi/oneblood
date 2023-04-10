<?php
include 'connection.php';
$id = $_GET['id'];

mysqli_query($con,"delete from ads_tb  where ad_id='$id'");
echo "<script>alert('deleted')</script>";
echo "<script>window.location.href='add_ads.php'</script>";



?>