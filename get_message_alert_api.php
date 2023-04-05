<?php
include 'connection_api.php';
$id=$_POST['id'];
$query=mysqli_query($con,"select * from chat_tb where reciever_id='$id'");

if($query){
   
    $num=mysqli_num_rows($query);
    echo json_encode($num);

}else{
echo json_encode('failed');
}



?>