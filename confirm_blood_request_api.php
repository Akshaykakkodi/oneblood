<?php
include 'connection_api.php';
$rId=$_POST['rId'];
$d_id=$_POST['d_id'];
$log=$_POST['log'];
$time=$_POST['time'];

$query=mysqli_query($con,"update blood_request_tb set status='accepted',donator_id='$d_id' where request_id='$rId' ");
// $query2=mysqli_query($con,"select * from registration_tb where login_id='$d_id' ");
// $row= mysqli_fetch_assoc($query2);
// $name=$row['name'];


if($query){
    $insert_query=mysqli_query($con,"insert into notification_tb (request_id,login_id,title,body,time_stamp) values('$rId','$log','Blood request Accepted!!','Your blood request is accepted.Check my requests for more details','$time')");
    if($insert_query){
        $response['message']='success';
    }
    
}else{
    $response['message']='failed';
}
echo json_encode($response);
?>