import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/api.dart';
import 'my_requests_screen.dart';

class My_accepted_requests extends StatefulWidget {
  const My_accepted_requests({Key? key}) : super(key: key);

  @override
  State<My_accepted_requests> createState() => _My_accepted_requestsState();
}

class _My_accepted_requestsState extends State<My_accepted_requests> {
  var login_id;
  Future getData() async {
    SharedPreferences spref=await SharedPreferences.getInstance();
    login_id=spref.getString('id');
    var data = await MyAcceptedRequests.getData(login_id);
    return data;
  }
  markComplete(id){
    showDialog(context: context, builder: (context) =>
        AlertDialog(
          title: Text('Alert'),
          content: Text('Are you sure to mark this request complete !!'),
          actions: [
            FloatingActionButton(
              backgroundColor: Colors.blueGrey,
              onPressed: () {

              },child: Text('cancel'),),
            FloatingActionButton(
              backgroundColor: Colors.redAccent,
              onPressed: () async {
                await CompleteRequests.getData(id);
                Navigator.push(context, MaterialPageRoute(builder: (context) => My_requests_screen(),));

              },child: Text('ok'),),
          ],
        ),);

  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context,snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
          return Center( child: CircularProgressIndicator(),);
    }
          if(snapshot.hasData && snapshot.data!=null){
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

                                      },
                                      child: Text('Mark complete',style: TextStyle(color: Colors.white),)),
                                  onPressed:  () {
                                    var id= snapshot.data[index]['request_id'];
                                    markComplete(id);
                                  },),
                              )
                            ],
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
                                    Text('(Remaining 4)',style: TextStyle(color: Colors.red),)
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
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text('Status:',style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                              Text(snapshot.data[index]['status'])
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text('Donor:',style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                              Text(snapshot.data[index]['name'],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),)
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
          else{
            return Center(child:Text('No data'),);
          }
        }
    );
  }
}
