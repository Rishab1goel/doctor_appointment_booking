import 'package:doctorappointmentbookingapp/colorScheme.dart';
import 'package:doctorappointmentbookingapp/screens/doctor_info_screen.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  static const String title = 'HomeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: CustomPaint(
              painter: pathPainter(),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar : AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: Icon(
                Icons.menu,
                color: Colors.black,
                size: 30,
              ),
              actions: [
                Container(
                  height: 75,
                  width: 75,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [getStartedColorStart, getStartedColorEnd],
                        stops: [0, 1]),
                  ),
                  child: Center(
                    child: Text(
                      'C',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                )
              ],
            ),
            body: Padding(
              padding: EdgeInsets.only(left: 20, right: 10, top: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Available Doctors",
                    style: TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    margin: EdgeInsets.only(top: 10),
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        categoryContainer("category7.png", "CT-Scan"),
                        categoryContainer("category1.png", "ortho"),
                        categoryContainer("category2.png", "dietician"),
                        categoryContainer("category3.png", "physician"),
                        categoryContainer("category4.png", "paralysis"),
                        categoryContainer("category5.png", "cardiology"),
                        categoryContainer("category6.png", "MRI-Scan"),
                        categoryContainer("category8.png", "Gynaecology"),
                      ],
                    ),
                  ),
                  Text(
                    "Chief Doctors",
                    style: TextStyle(
                        fontSize: 25, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        createDocWidget("doc1.png", "Susan Thomas"),
                        createDocWidget("doc2.png", "paul Barbara"),
                        createDocWidget("doc3.png", "Nancy Williams"),
                        createDocWidget("doc1.png", "Jacob jonas"),
                        createDocWidget("doc2.png", "Santo Riga"),
                        createDocWidget("doc3.png", "Willy Thomas"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
        ],
    );
  }

  Container categoryContainer(String imgName, String title) {
    return Container(
      width: 130,
      child: Column(
        children: [
          Image.asset('assets/$imgName'),
          Text(
            "$title",
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
          ),
        ],
      ),
    );
  }

  Container createDocWidget(String imgName, String docName) {
    return Container(
      child: InkWell(
        child: Container(
          margin: EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: docContentBgColor,
          ),
          child: Container(
            padding: EdgeInsets.all(7),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 70,
                  height: 90,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/$imgName'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Dr. $docName",
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "A brief about the doctor to be added here,this is more like an introduction",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400),
                        overflow: TextOverflow.clip,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.pushNamed(context, DoctorInfoScreen.title);
        },
      ),
    );
  }

}

class pathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = new Paint();
    paint.color = path2Color;

    Path path = new Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.3, 0);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.03,
        size.width * 0.42, size.height * 0.17);
    path.quadraticBezierTo(
        size.width * 0.35, size.height * 0.32, 0, size.height * 0.29);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
