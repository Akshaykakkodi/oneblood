<?php
include 'connection_api.php';
$query=mysqli_query($con,"select * from ads_tb");
$data=array();
if(mysqli_num_rows($query)>0){
    while($row=mysqli_fetch_assoc($query)){
        $data[]=$row;
        
    }
    echo json_encode($data);
}



?>