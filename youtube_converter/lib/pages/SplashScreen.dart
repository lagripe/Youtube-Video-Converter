import 'dart:async';
import 'package:flutter/material.dart';
import '../pages/HomePage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Container(child: Image(image: AssetImage("assets/img/Logo.png"),),)),);
  }
}
