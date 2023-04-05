<?php
include 'connection_api.php';
$blood=$_POST['blood'];
$query=mysqli_query($con,"select * from registration_tb where blood_group='$blood' and available_to_donate='yes'");
$data=array();
if(mysqli_num_rows($query)>0){

    while($row=mysqli_fetch_assoc($query)){
        $data[]=$row;

    }
    echo json_encode($data);
}


?>