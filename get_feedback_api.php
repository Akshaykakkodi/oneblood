<?php
include 'connection_api.php';
$query=mysqli_query($con,"select * from feedback_tb join registration_tb where feedback_tb.login_id=registration_tb.login_id");
$data=array();
if(mysqli_num_rows($query)>0){
    while($row=mysqli_fetch_assoc($query)){
        $data[]=$row;
    
    }
     echo json_encode($data);
}



?>