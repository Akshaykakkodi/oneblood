<?php
include 'connection_api.php';
$name=$_POST['name'];
$email=$_POST['email'];
$password=$_POST['password'];
$mobile=$_POST['mobile'];
$dob=$_POST['dob'];
$blood_group=$_POST['blood_group'];
$location=$_POST['location'];
$latitude=$_POST['latitude'];
$longitude=$_POST['longitude'];
$image = $_FILES['image']['name'];
$image_temp = $_FILES['image']['tmp_name'];

// move uploaded image to images directory
if ($image_temp) {
  $image_path = "images/" . $image;
  move_uploaded_file($image_temp, $image_path);
}


$email_exists_query=mysqli_query($con,"select * from login_tb where email_id='$email'");
if(mysqli_num_rows($email_exists_query)>0){
    $response['message']="Email already exists";
    echo json_encode($response);
}
else{
    $query1= mysqli_query($con,"insert into login_tb(email_id,password,type) values('$email','$password','user')");
    $log= mysqli_insert_id($con);
    $query2= mysqli_query($con,"insert into registration_tb(name,email_id,login_id,mobile_no,date_of_birth,blood_group,location,latitude,longitude,image) values('$name','$email','$log','$mobile','$dob','$blood_group','$location','$latitude','$longitude','$image_path')");
    
    if($query1 && $query2){
        $response['message']='success';
        $data=mysqli_query($con,"select * from registration_tb where email_id='$email'");
        $row=mysqli_fetch_assoc($data);
        $id=$row['login_id'];
        $response['id']=$id;
        
    }
    else{
        $response['message']='failed';
    }
    echo json_encode($response);
}





?>
