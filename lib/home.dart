import 'dart:async';
import 'package:flutter/material.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:oneblood/map_view.dart';
import 'package:oneblood/screens/bottomnavigation_home.dart';
import 'package:oneblood/screens/chat2.dart';
import 'package:oneblood/screens/donate_history_screen.dart';
import 'package:oneblood/screens/donate_screen.dart';
import 'package:oneblood/screens/hospital_service_screen.dart';
import 'package:oneblood/screens/login_screen.dart';
import 'package:oneblood/screens/my_profile_screen.dart';
import 'package:oneblood/screens/my_requests_screen.dart';
import 'package:oneblood/screens/notification_screen.dart';
import 'package:oneblood/screens/privacy_policy.dart';
import 'package:oneblood/screens/request_screen.dart';
import 'package:oneblood/screens/search_screen.dart';
import 'package:oneblood/service/api.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int indexnum = 0;
  List screens = [BottomNav_home(), Donate_screen(), Request_screen(),Chat2()];
  Timer? _timer;
   late var id;
    var notificationCount;
    var newNotificationCount;
   Widget NotiIcon=Icon(Icons.notifications);

 var notificationNum;
  getdata() async {
    SharedPreferences spref=await SharedPreferences.getInstance();
    id=spref.getString('id');
     notificationNum=await AlertNotification.getnum(id);

    // spref.setString('notiNum', notificationNum.toString());
    // alertnum=spref.getString('notiNum');


    return notificationNum;
  }
  @override
  void initState() {
    super.initState();



    // Refresh the screen every 5 seconds
    _timer = Timer.periodic(Duration(seconds: 15), (timer) {
      getdata().then((value){

        if(notificationNum>notificationCount){
          NotiIcon=  Stack(
            children:[
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Icon(Icons.notifications),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 13.0,top: 1),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Icon(Icons.circle,size: 10,color: Colors.blue,),
                ),
              )
            ],

          );
          setState(() {
          notificationCount=notificationNum;
          });
        }else{
          NotiIcon=Icon(Icons.notifications);
        }
      });



    }
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset:false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.red),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: indexnum == 0
            ? Row(
                children:  [
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.person),
                  ),
                  Text(
                    "Welcome",
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                ],
              )
            : indexnum == 1
                ? const Text(
                    'Recievers List',
                    style: TextStyle(color: Colors.red),
                  )
                :indexnum==2 ? const Text(
                    'Request Blood',
                    style: TextStyle(color: Colors.red),
                  ):const Text(
          'Chat',
          style: TextStyle(color: Colors.red),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: InkWell(
                onTap: () {
                  notificationCount=notificationNum;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Notification_screen(),
                      ));
                },
                child:NotiIcon,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Search_screen(),
                      ));
                },
                child: Icon(Icons.search)),
          )
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.redAccent,
        child: Column(
          children: [
            DrawerHeader(
              child: Image.asset(
                'Assets/images/oneblood.png',
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Map_view(),
                    ));
              },
              child: const ListTile(
                leading: Icon(Icons.location_on_outlined, color: Colors.white),
                title: Text(
                  'Map view',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => My_profile_screen(),
                  )),
              child: const ListTile(
                leading:
                    Icon(Icons.account_circle_outlined, color: Colors.white),
                title: Text(
                  'My profile',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => My_requests_screen(),
                    ));
              },
              child: const ListTile(
                leading: Icon(Icons.request_page_outlined, color: Colors.white),
                title: Text(
                  'My requests',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Donate_history_screen(),
                    ));
              },
              child: const ListTile(
                leading: Icon(Icons.history, color: Colors.white),
                title: Text(
                  'Donate history',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Hospital_service_screen(),
                    ));
              },
              child: const ListTile(
                leading:
                    Icon(Icons.local_hospital_outlined, color: Colors.white),
                title: Text(
                  'Hospital service',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Notification_screen(),
                    ));
              },
              child: const ListTile(
                leading: Icon(Icons.notifications_active_outlined,
                    color: Colors.white),
                title: Text(
                  'Notification',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Privacy_policy_screen(),
                    ));
              },
              child: const ListTile(
                leading: Icon(Icons.policy_outlined, color: Colors.white),
                title: Text(
                  'Privacy policy',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                SharedPreferences spref= await SharedPreferences.getInstance();
                spref.clear();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login_screen(),), (route) => false);
              },
              child: const ListTile(
                leading: Icon(Icons.logout_outlined, color: Colors.white),
                title: Text(
                  'Log out',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CircleNavBar(
        activeIcons: const [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.water_drop, color: Colors.white),
          Icon(Icons.get_app, color: Colors.white),
          Icon(Icons.chat_outlined, color: Colors.white),

        ],
        inactiveIcons: const [
          Text(
            "Home",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text("Donate",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          Text("Request",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          Text("Chat",
              style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        ],
        color: Colors.redAccent,
        circleColor: Colors.redAccent,
        height: 50,
        circleWidth: 50,
        activeIndex: indexnum,
        onTap: (index) {
          setState(() {
            indexnum = index;
          });
        },
        shadowColor: Colors.deepPurple,
        circleShadowColor: Colors.deepPurple,
        elevation: 10,
      ),
      body: screens.elementAt(indexnum),
    );
  }
}
