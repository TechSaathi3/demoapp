import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi/assistant/assistant_methods.dart';
import 'package:taxi/widgets/drawer.dart';
import 'package:taxi/models/user_model.dart';
import 'package:geolocator/geolocator.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({Key? key}) : super(key: key);

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController? newgooglemapcontroller;
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  GlobalKey<ScaffoldState> skey = GlobalKey<ScaffoldState>();
  double searchlocation = 220;
  AssistMethod assist = AssistMethod();
  late UserModel _userModel;
Position usercurrentposition = Position(
  latitude: 0,
  longitude: 0,
  heading: 0,
  speed: 0,
  speedAccuracy: 0,
  accuracy: 0,
  altitude: 0,
  timestamp: DateTime.now(),
  floor: 0,
  isMocked: false,
  altitudeAccuracy: 0,
  headingAccuracy: 0,
);
LocationPermission? _locationPermission;

checkifpermissionisallowed() async{
_locationPermission = await Geolocator.requestPermission();
if (_locationPermission == LocationPermission.denied) {
  await Geolocator.requestPermission();
}


}
locateuserposition() async {
  Position cposition = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
  usercurrentposition = cposition;
  LatLng latlangposition =
      LatLng(usercurrentposition.latitude, usercurrentposition.longitude);
  CameraPosition cameraposition =
      CameraPosition(target: latlangposition, zoom: 14);
  newgooglemapcontroller!.animateCamera(CameraUpdate.newCameraPosition(cameraposition));
}


  @override
  void initState() {
    super.initState();
    _initCurrentUserOnlineInfo();
    checkifpermissionisallowed();
  }


  _initCurrentUserOnlineInfo() async {
    try {
      UserModel userModel = await assist.readCurrentUserOnlineInfo();
      setState(() {
        _userModel = userModel;
      });
    } catch (error) {
      print('Error initializing user information: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: skey,
      drawer: mydrawer(
        email: _userModel.email??'',
        name: _userModel.name ?? '',
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newgooglemapcontroller = controller;
              locateuserposition();
            },
          ),
          Positioned(
            top: 36,
            left: 32,
            child: GestureDetector(
              onTap: () {
                skey.currentState!.openDrawer();
              },
              child: const CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.menu,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: AnimatedSize(
            curve: Curves.easeIn,
            duration: Duration(milliseconds: 120),
            child: Container(
              height: searchlocation,
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical:18 ),
                child: Column(
                  children: <Widget>[
                    //from location
                    Row(
                      children: <Widget>[
                        Icon(Icons.add_location_alt_outlined, color: Colors.grey,  ),
                      SizedBox(width: 12.0,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('from',
                          style: TextStyle(
                            color: Colors.grey,fontSize:12
                          ),),
                        Text('your current location',
                          style: TextStyle(
                            color: Colors.grey,fontSize:14
                          ),),  
                        ],
                      )
                      ],
                    ),
               const SizedBox(height: 10,),
               Divider(
                height: 1,
                thickness: 1,
                color: Colors.grey,
               ),
              SizedBox(height: 16,),

                    Row(
                      children: <Widget>[
                        Icon(Icons.add_location_alt_outlined, color: Colors.grey,  ),
                      SizedBox(width: 12.0,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('to',
                          style: TextStyle(
                            color: Colors.grey,fontSize:12
                          ),),
                        Text('where to go?',
                          style: TextStyle(
                            color: Colors.grey,fontSize:14
                          ),),  
                        ],
                      )
                      ],
                    ),
                      const SizedBox(height: 10,),
               Divider(
                height: 1,
                thickness: 1,
                color: Colors.grey,
               ),
              SizedBox(height: 16,),
              ElevatedButton(onPressed:(){} ,style: ElevatedButton.styleFrom(
                primary: Colors.green,
                textStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
              ), child: Text('Request a ride'))
                  ],
                ),
              ),
            ),
            ),
            ),
        ],
      ),
    );
  }
}
