<?php
include 'connection_api.php';
$d_id=$_POST['d_id'];
$query=mysqli_query($con,"select * from blood_request_tb where donator_id='$d_id' and status='accepted' ");
$data=array();
if(mysqli_num_rows($query)>0){
    while($row=mysqli_fetch_assoc($query)){
        $data[]=$row;
    }
    echo json_encode($data);
}



?>