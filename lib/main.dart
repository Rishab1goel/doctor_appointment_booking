import 'package:doctorappointmentbookingapp/screens/doctor_info_screen.dart';
import 'package:doctorappointmentbookingapp/screens/get_started_screen.dart';
import 'package:doctorappointmentbookingapp/screens/home_screen.dart';
import 'package:doctorappointmentbookingapp/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.title,
      routes:{
        SplashScreen.title: (context)=> SplashScreen(),
        GetStartedScreen.title : (context) => GetStartedScreen(),
        HomeScreen.title: (context)=>HomeScreen(),
        DoctorInfoScreen.title: (context) => DoctorInfoScreen(),
      },
    );
  }
}




