import 'package:doctorappointmentbookingapp/screens/doctor_info_screen.dart';
import 'package:doctorappointmentbookingapp/screens/get_started_screen.dart';
import 'package:doctorappointmentbookingapp/screens/home_screen.dart';
import 'package:doctorappointmentbookingapp/screens/doctor_profile_screen.dart';
import 'package:doctorappointmentbookingapp/screens/sign_in_screen.dart';
import 'package:doctorappointmentbookingapp/screens/sign_up_screen.dart';
import 'package:doctorappointmentbookingapp/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Ubuntu'),
      initialRoute: SplashScreen.title,
      routes:{
        SplashScreen.title: (context)=> SplashScreen(),
        GetStartedScreen.title : (context) => GetStartedScreen(),
        HomeScreen.title: (context)=>HomeScreen(),
        SignUpScreen.title: (context) => SignUpScreen(),
        SignInScreen.title: (context) => SignInScreen(),
        DoctorProfileScreen.title: (context) => DoctorProfileScreen(),
        
      },
    );
  }
}
