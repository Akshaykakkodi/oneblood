<?php
session_start();
include 'connection_api.php';
$id=$_POST['id'];
$query=mysqli_query($con,"select * from login_tb where login_id='$id'");
$data=array();
if(mysqli_num_rows($query)>0){
    while($row=mysqli_fetch_assoc($query)){
        $data=$row;
    }
    echo json_encode($data);
}

?>