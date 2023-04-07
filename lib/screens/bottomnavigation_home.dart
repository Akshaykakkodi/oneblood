import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:oneblood/screens/find_blood_bank.dart';
import 'package:oneblood/screens/hospital_service_screen.dart';
import 'package:oneblood/screens/my_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/api.dart';
import 'feedback_screen.dart';

class BottomNav_home extends StatefulWidget {
  BottomNav_home({Key? key}) : super(key: key);

  @override
  State<BottomNav_home> createState() => _BottomNav_homeState();
}

class _BottomNav_homeState extends State<BottomNav_home> {

  final List<String> imgList2=[
    'https://brandongaille.com/wp-content/uploads/2013/10/39-Catchy-Blood-Drive-Campaign-Slogans.jpg',
    'https://ntrtrust.org/wp-content/uploads/2021/01/WhatsApp-Image-2021-01-02-at-11.33.38.jpeg'
  ];
  List Adssss=[];

  var login_id;

  var AdData;

 Future getAd() async {
    AdData= await GetAds.getData();
    for(int i=0;i<AdData.length;i++){
      Adssss.add("${Service.imageBaseUrl}${AdData[i]["image"]}");
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    getAd();
    super.initState();
  }

  Future getUserData() async {
    SharedPreferences spref=await SharedPreferences.getInstance();
    login_id= spref.getString('id');

    print("login id $login_id");
   var details= await UserDetails.userData(login_id);

   return details;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserData(),
      builder: (context,snapshot) {
        if(snapshot.hasData){
          return Column(
            children: [
              SizedBox(
                child: Stack(
                  children: [
                    Container(
                      color: Colors.redAccent,
                      height: 80,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 100,
                          width: 300,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => My_profile_screen(),));
                            },
                            child: Card(
                              elevation: 5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:  [
                                      Text(
                                        snapshot.data['name'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      Text(
                                        'user',
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children:  [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.redAccent,
                                        child: Text(snapshot.data['blood_group'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Text(
                                        'Blood group',
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: SizedBox(
                  height: 465,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 150,
                          child: CarouselSlider(
                              items: imgList2
                                  .map((item) => Padding(
                                padding: EdgeInsets.all(5),
                                child: Center(
                                    child: ClipRRect(
                                      borderRadius:BorderRadius.circular(20) ,
                                      child: Image.network(item,
                                          fit: BoxFit.fill,
                                          width: MediaQuery.of(context)
                                              .size
                                              .width),
                                    )),
                              ))
                                  .toList(),
                              options: CarouselOptions(
                                autoPlay: true,
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 150,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Find_blood_bank(),));
                                    },
                                    child: Card(
                                      elevation: 5,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset('Assets/images/blood_bank.png',
                                              height: 60),
                                          const Center(
                                              child: Text(
                                                'Find blood banks',
                                                textAlign: TextAlign.center,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 150,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Hospital_service_screen(),));
                                    },
                                    child: Card(
                                      elevation: 5,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'Assets/images/Hospital.png',
                                            height: 65,
                                          ),
                                          Center(child: Text('Find hospital')),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 150,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Feedback_screen(),));
                                    },
                                    child: Card(
                                      elevation: 5,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset('Assets/images/feedback.png'),
                                          const Center(child: Text('Feedback')),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 150,
                          child: CarouselSlider(
                              items: Adssss
                                  .map((item) =>
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child:
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: Image.network(item,
                                              fit: BoxFit.fill,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width),
                                        )),
                                  ))
                                  .toList(),
                              options: CarouselOptions(
                                autoPlay: true,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        }else{
          return Center(child: CircularProgressIndicator());
        }

      }
    );
  }
}
