import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:oneblood/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/api.dart';

class Request_screen extends StatefulWidget {
  const Request_screen({Key? key}) : super(key: key);

  @override
  State<Request_screen> createState() => _Request_screenState();
}

class _Request_screenState extends State<Request_screen> {
  String value= 'Select';
  String value_unit='units';
  bool critical= false;
  var selectedDate;
  TextEditingController patient_name=TextEditingController();
  TextEditingController patient_age=TextEditingController();
  TextEditingController loc=TextEditingController();
  TextEditingController user=TextEditingController();
  TextEditingController userId=TextEditingController();


  Future getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {

      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {

      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position =  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks[0];
    print(placemark.subLocality! + ", " + placemark.locality!);
    loc.text=placemark.subLocality! + ", " + placemark.locality!;
  }

  var fkey= GlobalKey<FormState>();


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
  var login_id;
  var details;
  var type;
   getUserData() async {
    SharedPreferences spref=await SharedPreferences.getInstance();
    login_id= spref.getString('id');

    print("login id $login_id");
     details= await UserDetails.userData(login_id);
    print(details);
    print(details['name']);
    user.text=details['name'];
    userId.text=details['login_id'];
    return details;

  }
  @override
  void initState() {
    // TODO: implement initState
    getUserData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:Form(
          key: fkey,
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(child: Text('(Kindly fill the details correctly to help you better)')),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 10,left: 40,right: 40),
                child: TextFormField(
                  controller: patient_name,
                  validator: (v) {
                    if(v!.isEmpty){
                      return 'please enter patients name';
                    }

                  },
                  decoration: InputDecoration(
                    filled: true,
                      fillColor: Colors.blueGrey[50],
                      contentPadding: const EdgeInsets.all(10),
                      prefixIcon: const Icon(Icons.person),
                     label: const Text('Patients name'),
                      border: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(30))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 10,left: 40,right: 40),
                child: TextFormField(
                  controller: user,
                  decoration: InputDecoration(
                  filled: true,
                      fillColor: Colors.blueGrey[50],
                      contentPadding: const EdgeInsets.all(10),
                      prefixIcon: const Icon(Icons.person),
                      label: const Text('User'),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30))),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 10,left: 40,right: 40),
                child: DropdownButtonFormField(
                  validator: (v) {
                    if(value=='select'){
                      return 'please select a blood group';
                    }

                  },
                  value:value ,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.blueGrey[50],
                      contentPadding: const EdgeInsets.all(10),
                      prefixIcon: const Icon(Icons.bloodtype_outlined),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30))),

                  items: const [
                    DropdownMenuItem(value:'Select', child: Text('Select blood group')),
                    DropdownMenuItem(value: 'A+',child: Text('A+'),),
                    DropdownMenuItem(value: 'O+', child: Text('O+')),
                    DropdownMenuItem(value: 'B+', child: Text('B+')),
                    DropdownMenuItem(value: 'AB+', child: Text('AB+')),
                    DropdownMenuItem(value: 'A-', child: Text('A-')),
                    DropdownMenuItem(value: 'O-', child: Text('O-')),
                    DropdownMenuItem(value: 'B-', child: Text('B-')),
                    DropdownMenuItem(value: 'AB-', child: Text('AB-')),
                  ], onChanged: (v) {
                    setState(() {
                      value=v!;
                    });
                },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 10,left: 40,right: 40),
                child: TextFormField(
                  validator: (v) {
                    if(v!.isEmpty){
                      return 'select required date';
                    }
                  },
                  controller: TextEditingController(
                      text: selectedDate==null?
                      "" :
                      selectedDate
                  ),
                  decoration: InputDecoration(
                    filled: true,
                      fillColor: Colors.blueGrey[50],
                      contentPadding: const EdgeInsets.all(10),
                      prefixIcon: InkWell(
                        onTap: () => selectDate(context),
                          child: const Icon(Icons.calendar_month_outlined)),

                      label: const Text('Required date'),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30))),

                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 10,left: 40,right: 40),
                child: TextFormField(
                  validator: (v) {
                    if(v!.isEmpty){
                      return 'Enter patients age';
                    }
                  },
                  controller: patient_age,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blueGrey[50],
                      contentPadding: const EdgeInsets.all(10),
                      prefixIcon: const Icon(Icons.person),
                      label: const Text('Patient age'),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 10,left: 40,right: 40),
                child: DropdownButtonFormField(
                  validator: (v) {
                    if(v!.isEmpty){
                      return 'select required units';
                    }
                  },

                  value:value_unit ,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                      filled: true,
                      fillColor: Colors.blueGrey[50],
                      prefixIcon: const Icon(Icons.bloodtype_outlined),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30))),

                  items: const [
                    DropdownMenuItem(value:'units', child: Text('Units')),
                    DropdownMenuItem(value: '1',child: Text('1'),),
                    DropdownMenuItem(value: '2', child: Text('2')),
                    DropdownMenuItem(value: '3', child: Text('3')),
                    DropdownMenuItem(value: '4', child: Text('4')),
                    DropdownMenuItem(value: '5', child: Text('5')),
                    DropdownMenuItem(value: '6', child: Text('6')),
                    DropdownMenuItem(value: '7', child: Text('7')),
                    DropdownMenuItem(value: '8', child: Text('8')),
                  ], onChanged: (v) {
                  setState(() {
                    value_unit=v!;
                  });
                },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 10,left: 40,right: 40),
                child: TextFormField(
                  controller: loc,
                  validator: (v) {
                    if(v!.isEmpty){
                      return 'select location';
                    }
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blueGrey[50],
                      contentPadding: EdgeInsets.all(10),
                      prefixIcon: InkWell(
                        onTap: () {
                          getLocation();
                        },
                          child: const Icon(Icons.location_on)),
                      label: const Text('Please select location'),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30))),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('critical'),
                  Transform.scale(
                    scale: 0.75,
                    child: Switch(
                      activeColor: Colors.red,
                      value: critical,
                      onChanged: (v) {
                      setState(() {
                        critical=v!;
                      });
                    },),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () async {
                      if(fkey.currentState!.validate()){
                        if(value=='Select'){
                          showDialog(context: context, builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Alert'),
                              content: Text('Blood group required'),
                              actions: [
                                TextButton(onPressed: () {
                                  Navigator.of(context).pop();
                                }, child: Text('ok'))
                              ],
                            );

                          },);
                        }
                        if(value_unit=='units'){
                          showDialog(context: context, builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Alert'),
                              content: Text('Units required'),
                              actions: [
                                TextButton(onPressed: () {
                                  Navigator.of(context).pop();
                                }, child: Text('ok'))
                              ],
                            );

                          },);
                        }
                        critical==true?type='critical':type='normal';
                    var data=  await Service2.sendBloodRequest(patient_name.text,user.text,value,selectedDate,patient_age.text,value_unit,loc.text,type,userId.text);
                        EasyLoading.show(status: 'Sending request');
                        if(data==true){
                          Fluttertoast.showToast(msg: 'Request successfull');
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home(),), (route) => false);
                        }else if(data==false){
                          Fluttertoast.showToast(msg: 'Something went wrong');
                        }
                        EasyLoading.dismiss();

                      }
                    },
                   color: Colors.redAccent,
                    child: const Text('Send request',style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),

            ],
          ),
        )
      ),
    );
  }
}
