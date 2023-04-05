
<?php
session_start();
include 'connection_api.php';

$id=$_POST['id'];
$_SESSION['log']=$id;

// Retrieve chat partner ID(s)
$query1=mysqli_query($con,"SELECT DISTINCT CASE
WHEN sender_id = '$id' THEN reciever_id
ELSE sender_id
END AS chat_partner_id
FROM chat_tb
WHERE sender_id = '$id' OR reciever_id = '$id'");

if(mysqli_num_rows($query1)>0){
    $chat_partners = array();
    while($row=mysqli_fetch_assoc($query1)){
        $chat_partners[] = $row['chat_partner_id'];
    }
    
    // Retrieve user data for each chat partner ID
    $users_data = array();
    foreach ($chat_partners as $partner_id) {
        $query2=mysqli_query($con,"select * from registration_tb where login_id='$partner_id'");
        if(mysqli_num_rows($query2)>0){
            while($row=mysqli_fetch_assoc($query2)){
                $users_data[] = $row;
            }
        }
    }
    
    // Output user data as JSON string
    echo json_encode($users_data);
} else {
    echo json_encode(array());
}
?>



