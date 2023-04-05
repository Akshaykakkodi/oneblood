import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

class Service{

  static String baseUrl='http://192.168.68.190/oneblood_backend/';
   static Future<dynamic>sendData(String name,email,mobile_number,password,dob,location,blood_group,latitude,longitude,File? image)async{


     var re = MultipartRequest("POST", Uri.parse(Service.baseUrl+"registration_api.php"));
     re.fields["name"]=name;
     re.fields["email"]=email;
     re.fields["mobile"]=mobile_number;
     re.fields["password"]=password;
     re.fields["dob"]=dob;
     re.fields["location"]=location;
     re.fields["blood_group"]=blood_group;
     re.fields["latitude"]=latitude;
     re.fields["longitude"]=longitude;
     re.files.add(MultipartFile.fromBytes("image", File(image!.path).readAsBytesSync(),filename:image!.path));
    var response=await re.send();
    var responseBody=await response.stream.bytesToString();
    print(responseBody);
    if(response.statusCode==200){
      var data= jsonDecode(responseBody);
      if(data["message"]=="Email already exists"){
        return "Email already exists";
      }
      if(data["message"]=="success"){

        return true;
      }
      if(data["message"]=="failed"){
        return false;
      }

    }

   }



}

class Service2{

  static Future<dynamic>sendBloodRequest(String patients_name,user,blood_group,required_date,patient_age,units,location,status,login_id )async{
    final response=await post(Uri.parse(Service.baseUrl+'blood_request_insert_api.php'),body:{
      "patients_name": patients_name,
      "user":user,
      "blood_group":blood_group,
      "required_date":required_date,
      "patient_age":patient_age,
      "units":units,
      "location":location,
      "status":status,
      "login_id":login_id

    } );
    print(response.body);
    if(response.statusCode==200){

      var body = jsonDecode(response.body);

      if(body["message"]=="success"){
        return true;
      }
      return false;

    }

  }

}
class Service3{
  
  static Future<dynamic>fetchAllBloodGroupData() async {
    var response=await get(Uri.parse(Service.baseUrl+'all_blood_request_view_api.php'));
    var data= jsonDecode(response.body);
    if(response.statusCode==200){
      return  data;
    }else {
      throw Exception('Failed to load data');
    }
    
  }
}

class LoginApi{
 static Future<dynamic> userLogin(String email,password) async {
    var response=await post(Uri.parse(Service.baseUrl+'login_api.php'),body: {
      "email":email,
      "password":password,

    });
    print(response.body);
    if(response.statusCode==200){
      var body=jsonDecode(response.body);
      if(body["message"]=="success"){
        return body;
      }else if(body["message"]=="failed") {
        return body;
      }
    }

  }
}

class UserDetails{
  static Future<dynamic> userData(String id) async {
    var response=await post(Uri.parse(Service.baseUrl+'get_user_data_api.php'),body: {
      "id":id
    });
    var data= jsonDecode(response.body);
    if(response.statusCode==200){
      return  data;
    }else {
      throw Exception('Failed to load data');
    }

  }
}
class UserBlood{
  
static Future<dynamic> UserBloodGroupRequest(String id) async {
    var response=await post(Uri.parse(Service.baseUrl+'user_blood_group_view_api.php'),body: {
      "id":id
    });

    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      return data;
    }else{
      throw Exception('Failed');
    }

  }
}
class Confirmation{
 static Future<dynamic> AcceptRequest(String rId) async {
    var response=await post(Uri.parse(Service.baseUrl+'accept_request_api.php'),body: {
      "rId":rId
    });
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      return data;
    }else{
      throw Exception('Failed');
    }

  }
}

class Confirm{
  static Future<dynamic> ConfirmRequest(String rId,d_id,log,time) async {
    var response=await post(Uri.parse(Service.baseUrl+'confirm_blood_request_api.php'),body: {
      "rId":rId,
      "d_id":d_id,
      "log":log,
      "time":time
    });
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      if(data['message']=='success'){
        return true;
      }
      else {
        return false;
      }
    }else{
      throw Exception('Failed');
    }

  }
}
class PendingDonation{
 static Future<dynamic> getDetails(String d_id) async {
    var response=await post(Uri.parse(Service.baseUrl+'pending_donation_api.php'),body: {
      "d_id":d_id
    });
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      return data;
    }else{
      throw Exception('Failed');
    }

  }
}

class MyAcceptedRequests{

 static Future<dynamic> getData(String id) async {
    var response=await post(Uri.parse(Service.baseUrl+'my_accepted_requests_api.php'),body: {
      "id":id
    });
    var data= jsonDecode(response.body);
    if(response.statusCode==200){
      return data;
    }else{
      throw Exception('Failed');
    }
  }

}
class MyPendingRequests{

  static Future<dynamic> getData(String id) async {
    var response=await post(Uri.parse(Service.baseUrl+'my_pending_requests_api.php'),body: {
      "id":id
    });
    var data= jsonDecode(response.body);
    if(response.statusCode==200){
      return data;
    }else{
      throw Exception('Failed');
    }
  }

}
class CompleteRequests{

  static Future<dynamic> getData(String rId) async {
    var response=await post(Uri.parse(Service.baseUrl+'mark_request_complete_api.php'),body: {
      "rId":rId
    });
    var data= jsonDecode(response.body);
    if(response.statusCode==200){
      return data;
    }else{
      throw Exception('Failed');
    }
  }

}

class CompletedDonation{
  static Future<dynamic> getDetails(String d_id) async {
    var response=await post(Uri.parse(Service.baseUrl+'completed_donation_api.php'),body: {
      "d_id":d_id
    });
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      return data;
    }else{
      throw Exception('Failed');
    }

  }
}

class NumberOfDonation{
  static Future<dynamic> getDetails(String d_id) async {
    var response=await post(Uri.parse(Service.baseUrl+'number_of_donation_and_requests_api.php'),body: {
      "d_id":d_id
    });
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      return data;
    }else{
      throw Exception('Failed');
    }

  }
}
class UpdateAvailablity{
 static Future<dynamic> update(String id,status) async {
    var response=await post(Uri.parse(Service.baseUrl+'update_donation_availability_api.php'),body: {
      "id":id,
      "status":status
    });
    if(response.statusCode==200){
      return 'success';
    }
    else{
      return "failed";
    }
  }
}
class SearchUsers{

  static Future<dynamic> search(String blood) async {
    var response= await post(Uri.parse(Service.baseUrl+"search_api.php"),body: {
      "blood":blood
    });
    if(response.statusCode==200){
      var data=await jsonDecode(response.body);
      return data;
    }
    else{
      return 'failed';
    }
  }
}
class GetNotifications{
  static Future<dynamic> getData(String id) async {
    var a;
    var response= await post(Uri.parse(Service.baseUrl+"get_notification_api.php"),body: {
      "id":id
    });
    if(response.statusCode==200){
      var data= jsonDecode(response.body);
      return data;
    }else{
      return a ;
    }

  }
}

class SendMessage{
  static Future<dynamic> send(String r_id,s_id,message,time) async {

    var response= await post(Uri.parse(Service.baseUrl+"send_messages_api.php"),body: {
      "r_id":r_id,
      "s_id":s_id,
      "message":message,
      "time":time
    });
    if(response.statusCode==200){
      var data= jsonDecode(response.body);
      return "success";
    }else{
      return "failed" ;
    }

  }
}
class RecieveMessage{
  static Future<dynamic> getMessage(String r_id,s_id) async {

    var response= await post(Uri.parse(Service.baseUrl+"get_messages_api.php"),body: {
      "r_id":s_id,
      "s_id":r_id,

    });
    if(response.statusCode==200){
      var data= jsonDecode(response.body);
      return data;
    }else{
      return "failed" ;
    }

  }
}
class NoOfMessage{
  static Future<dynamic> getnum(String id) async {
    var response= await post(Uri.parse(Service.baseUrl+"get_chat_users_api.php"),body: {
      "id":id
    });
    if(response.statusCode==200){
      var data= jsonDecode(response.body);
      return data;
    }else{
      return "failed" ;
    }

  }
}
class AlertNotification{
  static Future<dynamic> getnum(String id) async {

    var response= await post(Uri.parse(Service.baseUrl+"get_notification_alert_api.php"),body: {
      "id":id

    });
    if(response.statusCode==200){
      var data= jsonDecode(response.body);
      return data;
    }else{
      return "failed" ;
    }

  }
}
class FeedBack{
  static Future<dynamic> insertFeedback(String id,feedback) async {

    var response= await post(Uri.parse(Service.baseUrl+"insert_feedback_api.php"),body: {
      "id":id,
      "feedback":feedback

    });
    if(response.statusCode==200){


      return true;
    }else{
      return "failed" ;
    }

  }
}

class GetNotification{
 static Future getData() async {
   var response= await get(Uri.parse(Service.baseUrl+"get_feedback_api.php"));
   var data=jsonDecode(response.body);
   if(response.statusCode==200){
     return data;
   }else {
     throw Exception('Failed to load data');
   }
  }

}
class AlertMessage{
  static Future<dynamic> getnum(String id) async {

    var response= await post(Uri.parse(Service.baseUrl+"get_message_alert_api.php"),body: {
      "id":id

    });
    if(response.statusCode==200){
      var data= jsonDecode(response.body);
      return data;
    }else{
      return "failed" ;
    }

  }
}
class UserChatAlert{
  static Future<dynamic> getnum(String id,sId) async {

    var response= await post(Uri.parse(Service.baseUrl+"user_message_alert_api.php"),body: {
      "id":id,
      "sId":sId

    });
    if(response.statusCode==200){
      var data= jsonDecode(response.body);
      return data;
    }else{
      return "failed" ;
    }

  }
}