<?php
include 'connection_api.php';
$id=$_POST['id'];
$status=$_POST['status'];
$query=mysqli_query($con,"update registration_tb set available_to_donate='$status' where login_id='$id'");
if($query){
    return $response['message']='success';
}else{
    return $response['message']='failed';
}


?>