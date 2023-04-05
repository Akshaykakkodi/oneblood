<?php
include 'connection_api.php';
$rId=$_POST['rId'];
$query= mysqli_query($con,"update blood_request_tb set status='completed' where request_id='$rId'");



if($query){

   
        $response['message']='success';

    
}else{
    $response['message']='failed';
}
echo json_encode($response);



?>