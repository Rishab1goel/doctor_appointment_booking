/// Splash screen is the intro screen which lasts for 3 seconds on app startup

import 'dart:async';
import 'package:doctorappointmentbookingapp/screens/home_screen_doctor.dart';
import 'package:flutter/material.dart';
import 'package:doctorappointmentbookingapp/screens/get_started_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  static const String title= 'splashScreen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<Timer> init() async {
    return Timer(Duration(seconds: 2), onDoneLoading);
  }

  onDoneLoading() async {
    _auth.currentUser==null
    ? Navigator.pushReplacementNamed(context, GetStartedScreen.title)
    : Navigator.pushReplacementNamed(context, HomeScreenDoctor.title);
  }

  @override
  void dispose() {
    super.dispose();
    // loadData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SizedBox(
          child: Image.asset(
            'assets/icons/app_icon.png',
            width: 100,
          ),
        ),
      ),
    );
  }
}
