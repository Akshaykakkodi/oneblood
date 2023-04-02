import 'package:flutter/material.dart';
import 'package:oneblood/screens/user_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/api.dart';

class Pending_requests extends StatefulWidget {
  const Pending_requests({Key? key}) : super(key: key);

  @override
  State<Pending_requests> createState() => _Pending_requestsState();
}

class _Pending_requestsState extends State<Pending_requests> {
  var login_id;
 Future getData() async {
    SharedPreferences spref=await SharedPreferences.getInstance();
    login_id= spref.getString('id');
   var data=await PendingDonation.getDetails(login_id);
   print(data);
   return data;
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context,snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }
        if(snapshot.hasData){
          return
               ListView.builder(
                 itemCount: snapshot.data.length,
                 itemBuilder: (context,index) {
                   return Container(
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
                                  children:  [
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
                              children:  [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Patient:',style: TextStyle(fontWeight: FontWeight.bold),),
                                ),
                                Text(snapshot.data[index]['patient_name'])
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Padding(
                                  padding:  EdgeInsets.only(left: 8.0),
                                  child: Row(
                                    children:  [
                                      Text('${snapshot.data[index]['units']} units'),
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
              );
                 }
               );
            }
        else{
          return Center(child: Text('No pending requests'),);
        }


      }

    );
  }
}
