<?php
include 'connection_api.php';
$id= $_POST['id'];
$feedback=$_POST['feedback'];
$query=mysqli_query($con,"insert into feedback_tb (login_id,feedback) values('$id','$feedback') ");
if($query){
    return $response['message']=['success'];
}else{
    return $response['message']=['failed'];
}



?>