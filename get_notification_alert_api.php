<?php
include 'connection_api.php';
$id=$_POST['id'];
$query=mysqli_query($con,"select * from notification_tb where login_id='$id'");
if($query){
   
        $num=mysqli_num_rows($query);
        echo json_encode($num);
    
}else{
    echo json_encode('failed');
}



?>