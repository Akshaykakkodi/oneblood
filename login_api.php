<?php
include 'connection_api.php';
$email=$_POST['email'];
$password=$_POST['password'];
$query=mysqli_query($con,"select * from login_tb where email_id='$email' and  password='$password'");
if($query){
    if(mysqli_num_rows($query)>0){
        $data=mysqli_fetch_assoc($query);
        $response["message"]="success";
        $response["id"]=$data["login_id"];
        echo json_encode($response);
    }
    else{
        $response["message"]="no user found";
        echo json_encode($response);
    }
    
}
else{
    $response["message"]="failed";
    echo json_encode($response);
}




?>