import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Hospital_service_screen extends StatefulWidget {
  const Hospital_service_screen({Key? key}) : super(key: key);

  @override
  State<Hospital_service_screen> createState() =>
      _Hospital_service_screenState();
}

class _Hospital_service_screenState extends State<Hospital_service_screen> {
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
        backgroundColor: Colors.red,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text('Hospital Service',style: TextStyle(color: Colors.white),),
        ),
        body: currentPosition != null
            ? Padding(
                padding: EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
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
