<?php
include 'connection_api.php';
$r_id=$_POST['r_id'];
$s_id=$_POST['s_id'];
$query=mysqli_query($con,"select * from chat_tb where (reciever_id='$r_id' AND sender_id='$s_id') OR (reciever_id='$s_id' AND sender_id='$r_id') order by time_stamp desc");
$data=array();
if(mysqli_num_rows($query)>0){
    while($row=mysqli_fetch_assoc($query)){
        $data[]=$row;
        
    }
    echo json_encode($data);
}


?>