<?php
include 'connection_api.php';
$id=$_POST['id'];
$mobile=$_POST['mobile'];
$password=$_POST['password'];
$query1=mysqli_query($con,"update login_tb set password='$password' where login_id='$id' ");
$query2=mysqli_query($con,"update registration_tb set mobile_no='$mobile' where login_id='$id'");
if($query1 && $query2){
    $response['message']= "success";
    echo json_encode($response);
}




?>