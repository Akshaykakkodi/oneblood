<?php
include 'connection_api.php';
$rId=$_POST['rId'];
$data= mysqli_query($con,"select * from blood_request_tb where request_id='$rId'");

$result=array();

if(mysqli_num_rows($data)>0){

    while($row=mysqli_fetch_assoc($data)){
        $result=$row;

    }
    echo json_encode($result);
}




?>