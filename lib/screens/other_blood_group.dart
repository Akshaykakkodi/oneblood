
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:oneblood/screens/user_profile_screen.dart';
import 'package:oneblood/service/api.dart';


class Other_blood_group extends StatefulWidget {
  const Other_blood_group({Key? key}) : super(key: key);

  @override
  State<Other_blood_group> createState() => _Other_blood_groupState();
}

class _Other_blood_groupState extends State<Other_blood_group> {
  var data;
 Future getData() async {
     data= await Service3.fetchAllBloodGroupData();
    print(data);
    return data;
  }
 shareMessage(int index) async {
   String message = "Patienat name:${data[index]['patient_name']}, Blood group:${data[index]['blood_group']},units:${data[index]['units']},Date:${data[index]['required_date']},Location:${data[index]['location']}";
   await FlutterShare.share(
       title: 'Share via WhatsApp',
       text: message,
       chooserTitle: 'Share via'
   );
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:   FutureBuilder(
        future: getData(),
        builder: (context,snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }

            if(snapshot.hasData && snapshot.data!=null){
              return  ListView.builder(
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
                                  children:  [
                                    Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: CircleAvatar(
                                        radius: 16,
                                        backgroundColor: Colors.red,
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
                                    child: Text('Share',style: TextStyle(color: Colors.white),),
                                    onPressed:  () {
                                      shareMessage(index);
                                    },),
                                )
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                // print(snapshot.data[index]['login_id']);
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
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Text('Patient:',style: TextStyle(fontWeight: FontWeight.bold),),
                                ),
                                Text(snapshot.data[index]['patient_name'])
                              ],
                            ),
                            Row(
                              children:  [
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
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Row(
                                    children:  [
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
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Row(
                                    children:  [
                                      Text('Request type'),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Text(snapshot.data[index]['type'],style: TextStyle(color: Colors.red),),
                                      )

                                    ],
                                  ),
                                ),

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
            return Center(child: Text('No data'));

        }
      ),
    );
  }
}
