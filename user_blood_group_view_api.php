<?php
include 'connection_api.php';
$id=$_POST['id'];
$query=mysqli_query($con,"select * from registration_tb where login_id='$id' ");
$result=array();
if(mysqli_num_rows($query)>0){
    while($row=mysqli_fetch_assoc($query)){
        $blood=$row['blood_group'];
    }
    $query2=mysqli_query($con,"select * from blood_request_tb where blood_group='$blood' and status='pending'");
    if(mysqli_num_rows($query2)>0){
        while($row2=mysqli_fetch_assoc($query2)){
            $result[]=$row2;
           
        }
        echo json_encode($result);
    }
    
}

?>