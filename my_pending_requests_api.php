<?php

include 'connection_api.php';
$id=$_POST['id'];
$data= mysqli_query($con,"SELECT *
FROM blood_request_tb
WHERE blood_request_tb.login_id = '$id' and blood_request_tb.status='pending'");

$result=array();

if(mysqli_num_rows($data)>0){

    while($row=mysqli_fetch_assoc($data)){
        $result[]=$row;

    }
    echo json_encode($result);
}




?>