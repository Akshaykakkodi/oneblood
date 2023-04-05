import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:oneblood/service/api.dart';
import 'login_screen.dart';


class Registration_screen extends StatefulWidget {
  const Registration_screen({Key? key}) : super(key: key);

  @override
  State<Registration_screen> createState() => _Registration_screenState();
}

class _Registration_screenState extends State<Registration_screen> {
  String value = "Select";
  var currentLocation;
  var selectedDate;
  var selectedDob;
  var lat;
  var long;
  bool privacyPolicy = false;
  XFile? pickedFile;
  File? image;
  TextEditingController name = TextEditingController();
  TextEditingController mobile_number = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController loc = TextEditingController();
  TextEditingController password = TextEditingController();


  uploadImage() async {
    ImagePicker picker= ImagePicker();
    pickedFile =await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image=File(pickedFile!.path);
    });
  }
  
 Future getLocation() async {
    Position position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks[0];
    lat=position.latitude.toString();
    long=position.longitude.toString();
    loc.text=placemark.subLocality! + ", " + placemark.locality!;
  }

  var fkey = GlobalKey<FormState>();

  Future selectDate(BuildContext context) async {
    var date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2024));
    if (date != null && date != selectedDate) {
      setState(() {
        selectedDate = DateFormat("dd-MM-yyyy").format(date);
      });
    }
  }

  Future selectDob(BuildContext context) async {
    var date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1970),
        lastDate: DateTime(2024));
    if (date != null && date != selectedDob) {
      setState(() {
        selectedDob =DateFormat("dd-MM-yyyy").format(date);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Form(
        key: fkey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () async {
                 await uploadImage();
                },
                child: Center(
                  child: CircleAvatar(

                    radius: 65,
                    foregroundImage:image!=null? FileImage(image!):null,
                    child:
                    Icon(Icons.add_a_photo,color: Colors.redAccent)


                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 40, right: 40),
              child: TextFormField(
                controller: name,
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'Enter name';
                  }
                },
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    filled: true,
                    fillColor: Colors.blueGrey[50],
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.red,
                    ),
                    label: const Text('Name'),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 40, right: 40),
              child: TextFormField(
                controller: password,
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'Enter a valid password';
                  }
                },
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    filled: true,
                    fillColor: Colors.blueGrey[50],
                    prefixIcon: const Icon(
                      Icons.person,
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
                validator: (v) {
                  

                  if (v!.isEmpty) {
                    return 'select date of birth';
                  }
                },
                controller: TextEditingController(
                    text: selectedDob == null
                        ? ""
                        : selectedDob),
                decoration: InputDecoration(
                    fillColor: Colors.blueGrey[50],
                    filled: true,
                    contentPadding: const EdgeInsets.all(10),
                    prefixIcon: InkWell(
                        onTap: () => selectDob(context),
                        child: const Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.red,
                        )),
                    label: const Text('Date of birth'),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 40, right: 40),
              child: TextFormField(
                controller: mobile_number,
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'Enter mobile number';
                  }
                  if (v!.length < 10) {
                    return 'Enter a valid number';
                  }
                },
                keyboardType: TextInputType.phone,
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
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 40, right: 40),
              child: TextFormField(
                controller: email,
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'Enter email';
                  }
                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.blueGrey[50],
                    contentPadding: const EdgeInsets.all(10),
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.red,
                    ),
                    label: const Text('Email id'),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 40, right: 40),
              child: DropdownButtonFormField(
                value: value,
                decoration: InputDecoration(
                    fillColor: Colors.blueGrey[50],
                    filled: true,
                    contentPadding: const EdgeInsets.all(10),
                    prefixIcon: const Icon(
                      Icons.water_drop,
                      color: Colors.red,
                    ),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                items: const [
                  DropdownMenuItem(
                      value: 'Select', child: Text('Select blood group')),
                  DropdownMenuItem(
                    value: 'A+',
                    child: Text('A+'),
                  ),
                  DropdownMenuItem(value: 'O+', child: Text('O+')),
                  DropdownMenuItem(value: 'B+', child: Text('B+')),
                  DropdownMenuItem(value: 'AB+', child: Text('AB+')),
                  DropdownMenuItem(value: 'A-', child: Text('A-')),
                  DropdownMenuItem(value: 'O-', child: Text('O-')),
                  DropdownMenuItem(value: 'B-', child: Text('B-')),
                  DropdownMenuItem(value: 'AB-', child: Text('AB-')),
                ],
                onChanged: (v) {
                  setState(() {
                    value = v!;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 40, right: 40),
              child: TextFormField(
                controller: loc,
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'slelect location';
                  }
                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.blueGrey[50],
                    contentPadding: const EdgeInsets.all(10),
                    prefixIcon: InkWell(
                      onTap: () {
                        getLocation();
                      },
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                    ),
                    label: const Text('Select location'),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
            ),



            CheckboxListTile(
              title: const Text(
                  'I have read and agree to Terms and conditions & Privacy policy'),
              value: privacyPolicy,
              onChanged: (v) {
                setState(() {
                  privacyPolicy = v!;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (fkey.currentState!.validate()) {
                      if (value == 'Select' || privacyPolicy == false) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Alert'),
                              content: const Text('Please fill all the required fields'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('ok'))
                              ],
                            );
                          },
                        );
                      }
                      else{
                        var data = await  Service.sendData(name.text,email.text,mobile_number.text,password.text,selectedDob.toString(),loc.text,value,lat,long,image);
                        print(" tis is send data ${data}");
                        EasyLoading.show(status: 'Registering');
                        if(data==true){
                          Fluttertoast.showToast(msg: 'Registered successfully');
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login_screen(),), (route) => false);
                        }else if(data==false){
                          Fluttertoast.showToast(msg: 'Something went wrong');
                        }
                        else if(data=="Email already exists"){
                          Fluttertoast.showToast(msg: 'Email id already registered');
                        }
                        EasyLoading.dismiss();

                      }




                    }

                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  child: const Text(
                    'Proceed',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
