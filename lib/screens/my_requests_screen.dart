import 'package:flutter/material.dart';
import 'package:oneblood/screens/my_accepted_requests.dart';
import 'package:oneblood/screens/my_pending_requests.dart';


class My_requests_screen extends StatefulWidget {
  const My_requests_screen({Key? key}) : super(key: key);

  @override
  State<My_requests_screen> createState() => _My_requests_screenState();
}

class _My_requests_screenState extends State<My_requests_screen> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('MY Requests',style: TextStyle(color: Colors.redAccent),),
          bottom: TabBar(

            labelColor: Colors.redAccent,
            indicatorColor: Colors.redAccent,
            tabs: [
              Tab(text: 'Pending',),
              Tab(text: 'Accepted',)
            ],
          ),
        ),
        body:  TabBarView(
          children: [
            My_pending_requests(),
            My_accepted_requests()
          ],
        )
      ),
    );
  }
}
