import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Find_blood_bank extends StatefulWidget {
  const Find_blood_bank({Key? key}) : super(key: key);

  @override
  State<Find_blood_bank> createState() => _Find_blood_bankState();
}

class _Find_blood_bankState extends State<Find_blood_bank> {
  var currentPosition;
  Future getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentPosition = position;
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
      backgroundColor: Colors.redAccent,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text('Find Blood Banks',style: TextStyle(color: Colors.white),),
        ),
        body: currentPosition != null
            ? Padding(
                padding: EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: LatLng(currentPosition.latitude,
                            currentPosition.longitude),
                        zoom: 13),
                    myLocationEnabled: true,
                    compassEnabled: true,
                    tiltGesturesEnabled: true,

                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
