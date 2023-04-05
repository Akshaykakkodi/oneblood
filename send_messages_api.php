<?php
include 'connection_api.php';
$r_id=$_POST['r_id'];
$s_id=$_POST['s_id'];
$message=$_POST['message'];
$time=$_POST['time'];
$query=mysqli_query($con,"insert into chat_tb (sender_id,reciever_id,message,time_stamp)values('$s_id','$r_id','$message','$time')");
if($query){
    $response['message']='success';

}else{
    $response['message']='failed';
}
echo json_encode($response);

?>