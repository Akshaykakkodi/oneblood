import 'package:flutter/material.dart';
import 'package:oneblood/service/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notification_screen extends StatefulWidget {
  const Notification_screen({Key? key}) : super(key: key);

  @override
  State<Notification_screen> createState() => _Notification_screenState();
}

class _Notification_screenState extends State<Notification_screen> {
  var id;
  var data;
   Future getData() async {
    SharedPreferences spref= await SharedPreferences.getInstance();
     id=spref.getString('id');
    data=await GetNotifications.getData(id);

    return data;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text('Notifications',style: TextStyle(color: Colors.redAccent),),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context,snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                var timestampParts =
                snapshot.data[index]['time_stamp'].split(' ');
                var date = timestampParts[0];
                var time = timestampParts[1];
                return ListTile(
                  title: Text(snapshot.data[index]['title']),
                  subtitle: Text(snapshot.data[index]['body']),
                  leading: Icon(Icons.notifications_active_outlined),

                  trailing: Column(
                    children: [
                      Text(date),
                      Text(time)
                    ],
                  ),

                );
              },);
          }else{
            return Text('No notifications');
          }

        }
      ),
    );
  }
}
