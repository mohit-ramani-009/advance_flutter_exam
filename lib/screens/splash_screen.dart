import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/');
    });

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(child: Text('All Countries',style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),)),
    );
  }
}
