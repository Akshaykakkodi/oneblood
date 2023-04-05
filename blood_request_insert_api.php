<?php
include 'connection_api.php';
$patients_name=$_POST['patients_name'];
$user=$_POST['user'];
$blood_group=$_POST['blood_group'];
$required_date=$_POST['required_date'];
$patient_age=$_POST['patient_age'];
$units=$_POST['units'];
$location=$_POST['location'];
$status=$_POST['status'];
$login_id=$_POST['login_id'];
$query= mysqli_query($con,"insert into blood_request_tb(patient_name,user_name,blood_group,required_date,patient_age,units,location,type,login_id)values('$patients_name','$user','$blood_group','$required_date','$patient_age','$units','$location','$status','$login_id')");
if($query){
    $response['message']='success';

}
else{
    $response['message']='falied';
}
echo json_encode($response);

?>