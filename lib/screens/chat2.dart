import 'dart:async';

import 'package:flutter/material.dart';
import 'package:oneblood/service/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chat_screen.dart';

class Chat2 extends StatefulWidget {
  const Chat2({Key? key}) : super(key: key);

  @override
  State<Chat2> createState() => _Chat2State();
}

class _Chat2State extends State<Chat2> {
  late String id;
  var c=0;

  void getId() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    setState(() {
      id = spref.getString('id') ?? '';
    });
    print(id);
  }

    getAlert(String sId) async {
      c++;
      if(c>1){
        var messageCount= await UserChatAlert.getnum(id, sId);
        print("count is sss $messageCount");
      }

    }



 Future getData() async {
    var data=await NoOfMessage.getnum(id);

    return data;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getId();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          if(snapshot.hasData){
            return  ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context,index) {


                  getAlert(snapshot.data[index]['login_id']);


                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Chat_Screen(reciever_id:snapshot.data[index]['login_id'],sender_id:id,user_name:snapshot.data[index]['name']),));
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 25,
                            foregroundImage: NetworkImage(Service.baseUrl+snapshot.data[index]['image'],) ,
                          ),
                          title: Text(snapshot.data[index]['name']),
                        ),
                      )
                  );
                }
            );
          }
       else{
         return Text('No data');
          }
      },),
    );
  }
}
