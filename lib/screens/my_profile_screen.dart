import 'dart:convert';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:oneblood/screens/edit_profile_screen.dart';
import 'package:oneblood/service/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';

class My_profile_screen extends StatefulWidget {
   My_profile_screen({Key? key}) : super(key: key);

  @override
  State<My_profile_screen> createState() => _My_profile_screenState();
}

class _My_profile_screenState extends State<My_profile_screen> {
  bool available_to_donate=false;
  var login_id;
  var numbers;
  var status;
  var imageBytes;
var data;
  Future getData() async {
    SharedPreferences spref=await SharedPreferences.getInstance();
     login_id= spref.getString('id');
     data=await UserDetails.userData(login_id);



    numbers=await NumberOfDonation.getDetails(login_id);

    return data;
  }
  editAvailability() async {
   available_to_donate==false?status='no':status='yes';
   var result=await UpdateAvailablity.update(login_id, status);

  }
  shareMessage() async {
    String message = "Download oneblood app , Donate blood and save life, download the app here playstore/oneblood";
    await FlutterShare.share(
        title: 'Share via WhatsApp',
        text: message,
        chooserTitle: 'Share via'
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text('Profile'),
        actions:  [ Padding(
          padding: EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Edit_profile_screen(),));
            },
              child: Icon(Icons.edit)),
        )],
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context,snapshot) {
          if(snapshot.hasData){
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 110,left: 110),
                  child: ExtendedImage.network(
                    Service.baseUrl+ data['image'],
                    height: 150,
                    shape: BoxShape.rectangle,
                    fit: BoxFit.fill,

                    cache: true,
                    border: Border.all(color: Colors.red, width: 1.0),

                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    //cancelToken: cancellationToken,
                  ),
                ),

                 Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: Text(snapshot.data['name'],style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Icon(Icons.location_on_outlined,color: Colors.red,),
                    Text(snapshot.data['location'])
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 130,
                          width: 120,
                          child: Card(
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  [
                                Text(snapshot.data['blood_group'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                                Text("Blood Group")
                              ],
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: SizedBox(
                          height: 130,
                          width: 120,
                          child:  Card(
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  [
                                Text(numbers['donations'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                                Text("Donations")
                              ],
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: Container(
                          height: 130,
                          width: 120,
                          child: Card(
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  [
                                Text(numbers['requests'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                                Text("Requested")
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                      tileColor: Colors.blueGrey[50],
                      title: const Text('Available to donate'),
                      leading: const Icon(Icons.event_available,color: Colors.red,),
                      trailing:Transform.scale(
                        scale: 0.75,
                        child: Switch(

                          activeTrackColor: Colors.red,
                          value: snapshot.data['available_to_donate']=='no'?false:true, onChanged: (v) {
                          setState(() {
                            available_to_donate=v!;

                          });
                          editAvailability();
                        },

                        ),
                      )

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      shareMessage();
                    },
                    child: ListTile(
                      tileColor: Colors.blueGrey[50],
                      title: const Text('Invite a friend'),
                      leading: const Icon(Icons.insert_invitation,color: Colors.red,),


                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    tileColor: Colors.blueGrey[50],
                    title: const Text('Get help'),
                    leading: const Icon(Icons.help,color: Colors.red,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async {
                      SharedPreferences spref= await SharedPreferences.getInstance();
                      spref.clear();
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login_screen(),), (route) => false);
                    },
                    child: ListTile(
                      tileColor: Colors.blueGrey[50],
                      title: const Text('Log out'),
                      leading: const Icon(Icons.logout_outlined,color: Colors.red,),


                    ),
                  ),
                ),
              ],
            );
          }else{
            return Center(child: CircularProgressIndicator());
          }

        }
      ),
    );
  }
}
