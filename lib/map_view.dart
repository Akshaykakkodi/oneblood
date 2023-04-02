import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map_view extends StatefulWidget {
   Map_view({Key? key}) : super(key: key);

  @override
  State<Map_view> createState() => _Map_viewState();
}

class _Map_viewState extends State<Map_view>{
   var currentPosition;
   var mapController;
   Set<Marker>markers={};
   _onMapcreated(GoogleMapController controller){

     mapController=controller;

     setState(() {
       markers.add(
         Marker(markerId: MarkerId('my marker'),
           position: LatLng(currentPosition.latitude,currentPosition.longitude),
           infoWindow: InfoWindow(
             title: 'marker',
             snippet: 'This is my first marker',
           )
         )
       );
     });
   }
 Future getLocation() async {
    Position position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentPosition=position;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    getLocation();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Map',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body:currentPosition!=null?
             Padding(
              padding: EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: GoogleMap(
                   onMapCreated: _onMapcreated,

                  initialCameraPosition: CameraPosition(
                      target: LatLng( currentPosition.latitude,currentPosition.longitude),
                      zoom: 13
                  ),
                  myLocationEnabled: true,
                  compassEnabled: true,
                  tiltGesturesEnabled: true,
                  markers: markers,

                ),
              ),
            ): Center(child: CircularProgressIndicator())

    );
  }
}
