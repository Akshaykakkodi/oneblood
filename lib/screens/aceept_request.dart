import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:oneblood/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/api.dart';

class Accept_request extends StatefulWidget {
  var id;

  var user_id;

   Accept_request({Key? key,required this.id,required this.user_id}) : super(key: key);

  @override
  State<Accept_request> createState() => _Accept_requestState();
}

class _Accept_requestState extends State<Accept_request> {
  var data;
  var login_id;
 Future getData() async {
   print('Rid is ${widget.user_id.toString()}');
   SharedPreferences spref=await SharedPreferences.getInstance();
   login_id= spref.getString('id');
   print(login_id);
     data=await Confirmation.AcceptRequest(widget.id.toString());
    print(data);

    return data;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Confirm Donation',style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          FutureBuilder(
            future: getData(),
            builder: (context,snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator(),);
              }
              else{
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: const [

                              Text('Requested by:',style: TextStyle(fontSize: 16,),),
                              Text('Requested blood group:',style: TextStyle(fontSize: 16,),),
                              Text('Patient:',style: TextStyle(fontSize: 16,),),
                              Text('Age:',style: TextStyle(fontSize: 16,),),
                              Text('Units:',style: TextStyle(fontSize: 16,),),
                              Text('Location:',maxLines: 2,style: TextStyle(fontSize: 16,),),
                              Text('Date:',style: TextStyle(fontSize: 16,),),
                            ],
                          ),
                          Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Row(
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(snapshot.data['user_name'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                  )
                                ],
                              ),
                              Row(
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(snapshot.data['blood_group'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                              Row(
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(snapshot.data['patient_name'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                              Row(
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(snapshot.data['patient_age'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                              Row(
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(snapshot.data['units'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                              Row(
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(snapshot.data['location'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                              Row(
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(snapshot.data['required_date'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

            }
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.only(top: 8.0,bottom: 8),
                child: Text('*Do not Donate blood if you have',style: TextStyle(color: Colors.redAccent),)
                ,
              ),
              Text('1. Not completed covid vaccination '),
              Text('2. Had tattoos in last 12 months '),
              Text('3. Donated blood in last 6 months '),
            ],
          ),



          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                    color: Colors.redAccent,onPressed: () async {

                      DateTime time = DateTime.now();
                      String stringTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(time);


                   var data=  await Confirm.ConfirmRequest(widget.id.toString(),login_id,widget.user_id.toString(),stringTime);
                   if(data==true){
                     Fluttertoast.showToast(msg: 'Accepted');
                     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home(),), (route) => false);
                   }else{
                     Fluttertoast.showToast(msg: 'something went wrong');
                   }


                }, child: const Text('Accept Request',style: TextStyle(color: Colors.white),)),

                MaterialButton(
                    color: Colors.deepPurple,onPressed: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home(),), (route) => false);

                }, child: const Text('Cancel',style: TextStyle(color: Colors.white),)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
