
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oneblood/screens/chat_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../service/api.dart';




class User_profile_screen extends StatefulWidget {
  var id;

   User_profile_screen({Key? key,required this.id}) : super(key: key);

  @override
  State<User_profile_screen> createState() => _User_profile_screenState();
}

class _User_profile_screenState extends State<User_profile_screen> {
  var phone;
  makeCall() async {
    final phoneNumber =phone;
    final uri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print('Could not launch ${uri.toString()}');
    }
  }
var id;
  var numbers;
  var data;
  var sender_id;
  getRecieverId() async {
    SharedPreferences spref= await SharedPreferences.getInstance();
    sender_id=spref.getString('id');

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecieverId();
  }
  Future getData() async {
    id=widget.id.toString();


     data=await UserDetails.userData(id);
    numbers=await NumberOfDonation.getDetails(id);
    phone=data['mobile_no'];

    return data;
  }
  var mapController;
  LatLng userLocation = LatLng(76.678, 87.6578);
  Set<Marker>markers={};
  _onMapcreated(GoogleMapController controller) {
    mapController = controller;

    setState(() {
      markers.add(
        Marker(
          markerId: MarkerId('user_location'),
          position:userLocation,
          infoWindow: InfoWindow(
            title: data['name'],
            snippet: data['location'],
          ),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title:
        const Text('Profile'),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context,snapshot) {
          if(snapshot.hasData){
            try {
              print(snapshot.data);
              userLocation = LatLng(double.parse(snapshot.data['latitude'] ?? '11.20'), double.parse(snapshot.data['longitude'] ?? '75.25'));
            } catch (e) {
              print("Error parsing double: $e");
              userLocation = LatLng(0, 0);
            }
            return ListView(

              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 110,left: 110),
                  child: ExtendedImage.network(
                    Service.baseUrl+ data['image'],
                    height: 150,
                    shape: BoxShape.rectangle,
                    fit: BoxFit.fill,

                    cache: true,
                    border: Border.all(color: Colors.red, width: 1.0),

                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    //cancelToken: cancellationToken,
                  ),
                ),
                 Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: Text(snapshot.data['name'],style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Icon(Icons.location_on_outlined,color: Colors.red,),
                    Text(snapshot.data['location'])
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton.extended(


                          label: Icon(Icons.phone,color: Colors.white),
                          backgroundColor: Colors.green,
                          onPressed: ()  {
                            makeCall();
                          }

                      ),
                      FloatingActionButton.extended(
                        backgroundColor: Colors.red,
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Chat_Screen(reciever_id:snapshot.data['login_id'],sender_id:sender_id,user_name:snapshot.data['name']),));
                        }, label: Icon(Icons.chat_outlined,color: Colors.white),

                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 130,
                          width: 120,
                          child: Card(
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  [
                                Text(snapshot.data['blood_group'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                                Text("Blood Group")
                              ],
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: SizedBox(
                          height: 130,
                          width: 120,
                          child:  Card(
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  [
                                Text(numbers['donations'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                                Text("Donations")
                              ],
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: SizedBox(
                          height: 130,
                          width: 120,
                          child: Card(
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  [
                                Text(numbers['requests'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                                Text("Requested")
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                 Padding(
                  padding: EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 350,

                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: GoogleMap(
                        onMapCreated: _onMapcreated,
                          markers: markers,
                          initialCameraPosition: CameraPosition(
                              target:userLocation,
                              zoom: 13

                          )
                      ),
                    ),
                  ),
                )

              ],
            );
          } else {
            return Center(child: CircularProgressIndicator(),);
          }

        }
      ),
    );
  }
}
