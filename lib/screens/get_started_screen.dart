import 'package:doctorappointmentbookingapp/colorScheme.dart';
import 'package:doctorappointmentbookingapp/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'signup_screen.dart';

class GetStartedScreen extends StatefulWidget {
  static const String title = 'getStartedScreen';

  @override
  _GetStartedScreenState createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
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
              Container(
                padding: EdgeInsets.all(50),
                margin: EdgeInsets.only(top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Doctor's appointment in 2 minutes",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Finding a doctor was never so easy",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.3,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Image(
                      image: AssetImage('assets/onBoardDocr.png'),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      child: Container(
                        height: 80,
                        width: 100,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              stops: [0, 1],
                              colors: [getStartedColorStart, getStartedColorEnd],
                            ),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                            )),
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

                    InkWell(
                      child: Container(
                        height: 80,
                        width: 200,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              stops: [0, 1],
                              colors: [getStartedColorStart, getStartedColorEnd],
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                            )),
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
                      onTap: () => Navigator.pushNamed(context, SignUpScreen.title),

                    ),
                  ],
                ),

              )
            ],
          )
        ],
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
