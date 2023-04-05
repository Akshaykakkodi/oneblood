<?php
include 'connection_api.php';
$data= mysqli_query($con,"select * from blood_request_tb where status='pending'");

$result=array();

if(mysqli_num_rows($data)>0){

    while($row=mysqli_fetch_assoc($data)){
        $result[]=$row;

    }
}
echo json_encode($result);



?>