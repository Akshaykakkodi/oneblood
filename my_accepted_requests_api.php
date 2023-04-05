<?php

include 'connection_api.php';
$id=$_POST['id'];
$data= mysqli_query($con,"SELECT *
FROM blood_request_tb
LEFT JOIN registration_tb
ON blood_request_tb.donator_id = registration_tb.login_id
WHERE blood_request_tb.login_id = '$id' and blood_request_tb.status='accepted'");

$result=array();

if(mysqli_num_rows($data)>0){

    while($row=mysqli_fetch_assoc($data)){
        $result[]=$row;

    }
    echo json_encode($result);
}




?>