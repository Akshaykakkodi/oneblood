import 'package:flutter/material.dart';

class Edit_profile_screen extends StatefulWidget {
  const Edit_profile_screen({Key? key}) : super(key: key);

  @override
  State<Edit_profile_screen> createState() => _Edit_profile_screenState();
}

class _Edit_profile_screenState extends State<Edit_profile_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit',style: TextStyle(color: Colors.redAccent),),
        centerTitle: true,
      ),
      body: ListView(

        children: [

          Center(child: Text("name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)),
          Center(child: Text("Email",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 18),)),
          Padding(
            padding: const EdgeInsets.only(
                top: 10, bottom: 10, left: 40, right: 40),
            child: TextFormField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blueGrey[50],
                  contentPadding: const EdgeInsets.all(10),
                  prefixIcon: const Icon(
                    Icons.password_outlined,
                    color: Colors.red,
                  ),
                  label: const Text('password'),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 10, bottom: 10, left: 40, right: 40),
            child: TextFormField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blueGrey[50],
                  contentPadding: const EdgeInsets.all(10),
                  prefixIcon: const Icon(
                    Icons.phone_android_outlined,
                    color: Colors.red,
                  ),
                  label: const Text('Mobile number'),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
          ),
        ],
      ),
    );
  }
}
