import 'package:flutter/material.dart';
import 'package:oneblood/home.dart';

class Otp_screen extends StatelessWidget {
  Otp_screen({Key? key}) : super(key: key);
  TextEditingController otp = TextEditingController();
  var fkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:false,

      body: SafeArea(
        child: Form(
          key: fkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'we have sent OTP to your mobile number',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 40.0, right: 40, top: 15, bottom: 15),
                child: TextFormField(
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'please enter the otp';
                    }
                  },
                  controller: otp,
                  decoration: InputDecoration(
                      filled: true,
                      focusColor: Colors.blueGrey[50],
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  cursorColor: Colors.red,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                ),
              ),
              FloatingActionButton.extended(
                backgroundColor: Colors.red,
                onPressed: () {
                  if (fkey.currentState!.validate()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ));
                  }
                },
                label: const Text(
                  'Verify',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
