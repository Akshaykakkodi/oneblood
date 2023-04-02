import 'package:flutter/material.dart';
import 'package:oneblood/screens/other_blood_group.dart';
import 'package:oneblood/screens/your_blood_group.dart';

class Donate_screen extends StatelessWidget {
  const Donate_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const DefaultTabController(

      length: 2,
      child: Scaffold(
        appBar:
        TabBar(
          labelColor: Colors.redAccent,
            indicatorColor: Colors.redAccent,
            tabs: [
              Tab(text: 'Your blood group',),
              Tab(text: 'All blood group',)
            ],
          ),
        backgroundColor: Colors.transparent,



        body: TabBarView(
          children: [
           Your_blood_group(),
           Other_blood_group()

          ],

        ),
      ),
    );
  }
}
