<?php
include 'connection_api.php';
$id=$_POST['id'];
$query=mysqli_query($con,"select * from notification_tb where login_id='$id' order by time_stamp desc");
$data=array();
if(mysqli_num_rows($query)>0){

    while($row=mysqli_fetch_assoc($query)){
        $data[]=$row;

    }
    echo json_encode($data);
}



?>