import 'package:doctorappointmentbookingapp/colorScheme.dart';
import 'package:doctorappointmentbookingapp/screens/get_started_screen.dart';
import 'package:doctorappointmentbookingapp/services/doctor_service.dart';
import 'package:doctorappointmentbookingapp/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DoctorProfileScreen extends StatefulWidget {
  static const String title = 'DoctorProfileScreen';
  @override
  _DoctorProfileScreenState createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [getStartedColorStart, getStartedColorEnd],
            begin: Alignment(0, -1.15),
            end: Alignment(0, 0.1),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Image.asset('assets/bg1.png'),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: bgColor,
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            child: Image.asset('assets/doc1.png'),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Dr. ${DoctorService.currentDoctor!.name}",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 6,),
                                Text(
                                  "Specialization : ${DoctorService.currentDoctor!.specialization}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 20,),
                          Text("Your Contact Information",style: TextStyle(fontSize: 20,fontWeight:FontWeight.w800),),
                          SizedBox(height: 10,),
                          Text(
                            "Email : ${DoctorService.currentDoctor!.email}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: 6,),
                          Text(
                            "Phone : ${DoctorService.currentDoctor!.phone}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: 50,),
                            Center(
                              child: ElevatedButton(
                                child: Text(
                                  'SIGN OUT',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                onPressed: () {
                                  showConfirmationDialog(
                                    context: context, 
                                    trueLabel: 'SIGN OUT', 
                                    falseLabel: 'CANCEL', 
                                    titleText: 'Sign Out',
                                    contentText: 'Are you sure you want to sign out?',
                                    onTrue: (){
                                      _auth.signOut();
                                        Navigator.pop(context);
                                        Navigator.pushReplacementNamed(
                                            context, GetStartedScreen.title);
                                    }, 
                                    onFalse: (){
                                      Navigator.pop(context);
                                    }
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xffff5757),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
