import 'package:flutter/material.dart';
import 'package:taxi/global/global.dart';
import 'package:taxi/screens/splash_screen.dart';

class mydrawer extends StatefulWidget {
 late String name;
late String email;
mydrawer({required this.name, required this.email});
  @override
  State<mydrawer> createState() => _mydrawerState();
}

class _mydrawerState extends State<mydrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 165,
            color: Colors.grey,
            child: DrawerHeader(child: Row(
              children: [
                Icon(Icons.person,
                size: 80,
                color: Colors.grey,),
                SizedBox(width: 16,),
                Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                Text(widget.name.toString(),
                style: const TextStyle(
                  fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 10,),
                 Text(widget.email.toString(),
                style: const TextStyle(
                  fontSize: 16,
                color: Colors.grey,
               
                ),),
               ],
                ),
              ],
            ),
            decoration: BoxDecoration(color: Colors.black),),
          ),
        SizedBox(height: 12.0,),
        GestureDetector(
          onTap: (){},
          child: ListTile(
            leading: Icon(Icons.history, color: Colors.black54,),
           title: Text('History',
           style: TextStyle(
            color: Colors.black54
           ),
           ), 
          ),
        ),
          GestureDetector(
          onTap: (){},
          child: ListTile(
            leading: Icon(Icons.person, color: Colors.black54,),
           title: Text('visit profile',
           style: TextStyle(
            color: Colors.black54
           ),
           ), 
          ),
        ),
          GestureDetector(
          onTap: (){},
          child: ListTile(
            leading: Icon(Icons.info, color: Colors.black54,),
           title: Text('About',
           style: TextStyle(
            color: Colors.black54
           ),
           ), 
          ),
        ),
          GestureDetector(
          onTap: (){
            fAuth.signOut();
            Navigator.push(context, MaterialPageRoute(builder: (c)=> const mysplashscreen()));
          },
          child: ListTile(
            leading: Icon(Icons.logout, color: Colors.black54,),
           title: Text('sign out',
           style: TextStyle(
            color: Colors.black54
           ),
           ), 
          ),
        ),
        ],
      ),
    );
  }
}