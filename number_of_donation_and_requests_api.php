<?php
include 'connection_api.php';
$d_id=$_POST['d_id'];
$query=mysqli_query($con,"select * from blood_request_tb where donator_id='$d_id' and status='completed' ");
$query2=mysqli_query($con,"select * from blood_request_tb where login_id='$d_id'  ");

if($query && $query2){
    $donations=mysqli_num_rows($query);
    $requests=mysqli_num_rows($query2);
    $response['donations']="$donations";
    $response['requests']="$requests";

    echo json_encode($response);
  
}
else{
    echo 'failed';
}



?>