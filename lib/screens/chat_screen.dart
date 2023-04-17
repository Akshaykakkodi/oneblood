import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:oneblood/screens/user_profile_screen.dart';
import 'package:oneblood/service/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chat_Screen extends StatefulWidget {
  var reciever_id;

  var sender_id;

  var user_name;

   Chat_Screen({Key? key,required this.reciever_id,required this.sender_id,required this.user_name}) : super(key: key);

  @override
  State<Chat_Screen> createState() => _Chat_ScreenState();
}

class _Chat_ScreenState extends State<Chat_Screen> {
  var receiverId;
  var senderId;
  TextEditingController message=TextEditingController();
  var fkey= GlobalKey<FormState>();
var data;
var log;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Refresh the screen every 5 seconds
    _timer = Timer.periodic(Duration(seconds: 30), (timer) {
      setState(() {});
    }
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

 Future getdata() async {
   receiverId = widget.reciever_id;
   senderId = widget.sender_id;

   SharedPreferences spref=await SharedPreferences.getInstance();
   log=spref.getString('id');

   print("r id is $senderId, $receiverId");


    data=await RecieveMessage.getMessage(senderId, receiverId);
   print("messages is $data");
   return data;
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,

        title: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => User_profile_screen(id: receiverId),));
          },
            child: Text(widget.user_name,style: TextStyle(color: Colors.white),)),
        centerTitle: true,

      ),
      body: Form(
        key: fkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,


          children: [
            Expanded(

              child: SizedBox(

                child: FutureBuilder(
                  future: getdata(),
                  builder: (context,snapshot) {
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator(),);
                    }
                    if(snapshot.hasData){
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        reverse: true,
                        itemBuilder: (context, index) {
                          var timestampParts =
                          snapshot.data[index]['time_stamp'].split(' ');
                          var date = timestampParts[0];
                          var time = timestampParts[1];
                          return Padding(
                            padding:  const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.95,
                                  // color: Colors.teal,
                                  child: Column(
                                    crossAxisAlignment:log==snapshot.data[index]['sender_id']?CrossAxisAlignment.end:CrossAxisAlignment.start,
                                    children: [
                                      Card(

                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(snapshot.data[index]['message'],style: TextStyle(fontSize: 16),),
                                          )),
                                      Column(
                                        children: [
                                          Text(time,style: const TextStyle(color: Colors.grey,fontSize: 11),),
                                          Text(date,style: const TextStyle(color: Colors.grey,fontSize: 11),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },);
                    }else{
                      return const Text('No messages');
                    }

                  }
                ),
              ),
            ),

            SizedBox(

              child:
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: message,
                  validator:  (value) {
                    if(value!.isEmpty){
                      return "Enter a message";
                    }
                  },
                  maxLines: 4,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(2),
                      suffixIcon:
                      InkWell(
                          onTap: () async {
                            if(fkey.currentState!.validate()){
                              DateTime time = DateTime.now();
                              String stringTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(time);
                              var res= await SendMessage.send(receiverId, senderId, message.text, stringTime);
                              if(res=="success"){
                                Fluttertoast.showToast(msg: 'send');
                                message.clear();
                                setState(() {

                                });
                              }else{
                                Fluttertoast.showToast(msg: 'failed to send');
                              }
                            }

                          },
                          child: const Icon(Icons.send,color: Colors.red,)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
            )
          ],

        ),
      ),
    );
  }
}
