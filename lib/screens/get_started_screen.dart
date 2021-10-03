import 'package:doctorappointmentbookingapp/colorScheme.dart';
import 'package:doctorappointmentbookingapp/screens/home_screen.dart';
import 'package:doctorappointmentbookingapp/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetStartedScreen extends StatefulWidget {
  static const String title = 'getStartedScreen';
  @override
  _GetStartedScreenState createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: CustomPaint(
                    painter: pathPainter(),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                      margin: EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Book Doctor Appointment Online",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w900),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Finding a doctor was never so easy",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: MediaQuery.of(context).size.height*.35,
                            child: Center(
                              child: Image(
                                image: AssetImage('assets/onBoardDocr.png'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    InkWell(
                      child: Container(
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              stops: [0, 1],
                              colors: [getStartedColorStart, getStartedColorEnd],
                            ),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            "Enter as Doctor",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      onTap: () async {
                        await Navigator.pushNamed(context, SignUpScreen.title);
                        if(_auth.currentUser!=null)
                        {
                          Navigator.pushReplacementNamed(context, HomeScreen.title);
                        }
                        
                      }
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      child: Container(
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              stops: [0, 1],
                              colors: [getStartedColorStart, getStartedColorEnd],
                            ),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Center(
                          child: Text(
                            "Enter as patient",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      onTap: () => Navigator.pushNamed(context, HomeScreen.title),
                    ),
                    SizedBox(height: 50,)
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class pathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = path1Color;
    paint.style = PaintingStyle.fill;
    var path = Path();
    path.moveTo(0, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.35, size.height * 0.40,
        size.width * 0.58, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.72, size.height * 0.8,
        size.width * 0.92, size.height * 0.8);
    path.quadraticBezierTo(
        size.width * 0.98, size.height * 0.8, size.width, size.height * 0.82);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
