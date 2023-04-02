import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oneblood/home.dart';
import 'package:oneblood/screens/registration_screen.dart';
import 'package:oneblood/service/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login_screen extends StatelessWidget {
   Login_screen({Key? key}) : super(key: key);
  TextEditingController email= TextEditingController();
   TextEditingController password= TextEditingController();
  var fkey= GlobalKey<FormState>();
  var data;
  getId() async {
    SharedPreferences spref=await SharedPreferences.getInstance();
    spref.setString('id',data['id'] );
    // print(data['id']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: fkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('Assets/images/oneblood.png',height: 200,width: 200,),
            Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 10,left: 40,right: 40),
              child: TextFormField(
                controller: email,
                validator: (v) {
                  if(v!.isEmpty){
                    return 'please enter email id';
                  }
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    filled: true,
                    fillColor: Colors.blueGrey[50],
                    prefixIcon: Icon(Icons.email_outlined,color: Colors.red,),
                    prefixStyle: TextStyle(color: Colors.black),
                    hintText: 'Email id',
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 10,left: 40,right: 40),
              child: TextFormField(
                obscureText: true,
                controller: password,
                validator: (v) {
                  if(v!.isEmpty){
                    return 'please enter password';
                  }
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    filled: true,
                    fillColor: Colors.blueGrey[50],
                    prefixIcon: Icon(Icons.password_outlined,color: Colors.red,),
                    prefixStyle: TextStyle(color: Colors.black),
                    hintText: 'Password',
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
            ),
            FloatingActionButton.extended(
                backgroundColor: Colors.red,
                onPressed:() async {
                  if(fkey.currentState!.validate()){
                    EasyLoading.show(status: 'Loading');
                   data= await LoginApi.userLogin(email.text,password.text);
                    if(data["message"]=="success"){
                     await getId();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Home(),));
                    }else{
                      Fluttertoast.showToast(msg: 'Wrong Email or password');
                    }

                  }
                  EasyLoading.dismiss();

            }, label: Text('Login',style: TextStyle(color: Colors.white),)),
            TextButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Registration_screen(),));
            }, child: Text('New user sign up',style:  TextStyle(color: Colors.red),))
          ],
        ),
      ),
    );
  }
}
