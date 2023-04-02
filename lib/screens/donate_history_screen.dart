import 'package:flutter/material.dart';
import 'package:oneblood/screens/completed_requests.dart';
import 'package:oneblood/screens/pending_requests.dart';

class Donate_history_screen extends StatelessWidget {
  const Donate_history_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text('Donate History',style: TextStyle(color: Colors.red),),
          bottom: TabBar(

            labelColor: Colors.redAccent,
            indicatorColor: Colors.redAccent,
            tabs: [
              Tab(text: 'Pending',),
              Tab(text: 'Completed',)
            ],
          ),
        ),
        body: TabBarView(

          children: [
            Pending_requests(),
            Completed_requests()
          ],

        ),
      ),
    );
  }
}
