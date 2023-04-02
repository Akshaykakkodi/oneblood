import 'package:flutter/material.dart';
import 'package:oneblood/screens/aceept_request.dart';
import 'package:oneblood/screens/user_profile_screen.dart';
import 'package:oneblood/service/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Your_blood_group extends StatefulWidget {
  const Your_blood_group({Key? key}) : super(key: key);

  @override
  State<Your_blood_group> createState() => _Your_blood_groupState();
}

class _Your_blood_groupState extends State<Your_blood_group> {
  var login_id;
 Future<dynamic> getData() async {
    SharedPreferences spref=await SharedPreferences.getInstance();
    login_id=spref.getString('id');
    print(login_id);
   var data=await UserBlood.UserBloodGroupRequest(login_id);
   return data;
  }

  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
    body:
      FutureBuilder(
        future:getData(),
        builder: (context,snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return  Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      elevation: 10,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: CircleAvatar(
                                      radius: 16,
                                      backgroundColor: Colors.redAccent,
                                      child: Text(snapshot.data[index]['blood_group'],style: TextStyle(color: Colors.white),),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Request Blood',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),


                              Padding(
                                padding: const EdgeInsets.only(right: 20.0,top: 10),
                                child: MaterialButton(
                                  color: Colors.red,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Accept_request(id:snapshot.data[index]['request_id'],user_id:snapshot.data[index]['login_id']),));
                                    },
                                      child: Text('Donate',style: TextStyle(color: Colors.white),)),
                                  onPressed:  () {

                                  },),
                              )
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => User_profile_screen(id:snapshot.data[index]['login_id']),));
                            },
                            child: Row(
                              children: [
                                Text('Requested by:'),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage('https://wallpaperaccess.com/full/2213424.jpg'),
                                  ),
                                ),
                                Text(snapshot.data[index]['user_name'],style: TextStyle(fontWeight: FontWeight.bold),)
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text('Patient:',style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                              Text(snapshot.data[index]['patient_name'])
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text('Age:',style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                              Text(snapshot.data[index]['patient_age'])
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  children: [
                                    Text('Needs ${snapshot.data[index]['units']} units'),

                                  ],
                                ),
                              ),
                               Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Text('Date: ${snapshot.data[index]['required_date']}'),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all( 10.0),
                                child: Row(
                                  children:  [
                                    Icon(Icons.location_on_outlined),
                                    Text(snapshot.data[index]['location'])
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all( 10.0),
                                child: CircleAvatar(
                                  radius: 15,
                                  child: Icon(Icons.share_outlined),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ) ;
              },);
          }
          else {
            return Center(child: Text('No Active Requests',style: TextStyle(color: Colors.redAccent),));
          }

        }
      ),
    );



  }
}
