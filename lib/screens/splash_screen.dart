import 'dart:async';

import 'package:flutter/material.dart';
import 'package:oneblood/home.dart';
import 'package:oneblood/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sscreen extends StatefulWidget {
  const Sscreen({Key? key}) : super(key: key);

  @override
  State<Sscreen> createState() => _SscreenState();
}

class _SscreenState extends State<Sscreen> {
  var id;

  checkLoggedIn() async {
    SharedPreferences spref= await SharedPreferences.getInstance();
    id=spref.getString('id');

  }
  @override
  void initState() {
   
    // TODO: implement initState
    super.initState();
    checkLoggedIn();
    Timer(Duration(seconds:3), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => id==null?Login_screen():Home(),)),);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Image.asset('Assets/images/oneblood.png',width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,)
    );
  }
}
