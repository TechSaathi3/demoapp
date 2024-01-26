import 'dart:async';
import 'package:taxi/assistant/assistant_methods.dart';
import 'package:taxi/authentication/login_screen.dart';
import 'package:taxi/global/global.dart';
import 'package:flutter/material.dart';
import 'package:taxi/screens/main_screen.dart';
import 'package:taxi/screens/main_screen.dart';
import 'package:taxi/screens/welcome.dart';

class mysplashscreen extends StatefulWidget {
  const mysplashscreen({super.key});

  @override
  State<mysplashscreen> createState() => _mysplashscreenState();
}
AssistMethod assist = AssistMethod();
class _mysplashscreenState extends State<mysplashscreen> {
  startTimer() async {
 
    Timer(Duration(seconds: 2), () async {
      {
      if(await fAuth.currentUser != null)
      {
        currentFirebaseUser = fAuth.currentUser;
        Navigator.push(context, MaterialPageRoute(builder: (c)=> Mainscreen()));
      }
      else
      {
         Navigator.push(context, MaterialPageRoute(builder: (c)=> Welcome()));
      }
    }}
    );

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           Image.asset('images/U-Drive.png'),
           SizedBox(height: 15,),
           Text('udrive',
           style: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold
           ),
           ),
          ],
        ),
      ),
    );
  }
}