import 'package:flutter/material.dart';
import 'package:advance_flutter_exam/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/');
    });

    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
