import 'dart:developer';

import 'package:doctorappointmentbookingapp/colorScheme.dart';
import 'package:doctorappointmentbookingapp/models/doctor.dart';
import 'package:doctorappointmentbookingapp/screens/doctor_info_screen.dart';
import 'package:doctorappointmentbookingapp/screens/doctor_profile_screen.dart';
import 'package:doctorappointmentbookingapp/services/doctor_service.dart';
import 'package:doctorappointmentbookingapp/services/network_connection_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeScreen extends StatefulWidget {
  static const String title = 'HomeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  var _databaseReference = FirebaseDatabase.instance.reference().child('doctors');
  bool _isConnected = false;

  @override
  void initState() {
    refresh();
    setProfile();
    super.initState();
  }

  Future setProfile() async{
    if(_auth.currentUser!=null)
      await DoctorService.setCurrentDoctor(uid: _auth.currentUser!.uid);
  }

  Future refresh() async {
    log('Refreshing home in screen...');
    _isConnected = await NetworkConnection.isConnected();
    setState(() {
      
    });
  }


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
              leading: Image.asset('assets/icons/app_icon.png'),
              title: Text('Doctor +',
                style: TextStyle(
                  color: Color(0xff353538),
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                if(_auth.currentUser!=null)
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, DoctorProfileScreen.title);
                    },
                    child: Center(
                      child: Image.asset(
                        'assets/doc1.png',
                        fit: BoxFit.fill,
                      ),

                    ),
                  ),

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
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     await DoctorService.fetchDoctors();
                  //   },
                  //   child: Text('Read'),
                  // ),

                  Text(
                    "All Doctors",
                    style: TextStyle(
                        fontSize: 25, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: RefreshIndicator(
                        onRefresh: ()async{
                          await refresh();
                        },
                        child: 
                        _isConnected ?
                          StreamBuilder<List<Doctor>?>(
                            stream: DoctorService.fetchDoctors(),
                            builder: (context, snapshot) {
                              List<Doctor>? allDoctors =  snapshot.data;
                              return snapshot.hasError 
                              ? Center(child: Text('Something went wrong'),)
                              : snapshot.hasData 
                                ? ListView.builder(
                                    itemCount: allDoctors!.length,
                                    itemBuilder: (context,index){
                                      return createDoctorWidget(
                                        imgName: "doc${(index)%3 +1}.png",
                                        doctor: allDoctors[index],                                
                                      );
                                    }
                                  )
                                : Center(child: CircularProgressIndicator() );
                            }
                          )
                          : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('No network'),
                                ElevatedButton(onPressed: ()async{refresh();}, 
                                  child: Text('Refresh'))
                              ],
                            ),
                          ),
                      )
                    )                      
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

  Container createDoctorWidget({
    required String imgName, 
    required Doctor doctor
    }) {
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Dr. ${doctor.name}",
                          style:
                              TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${doctor.specialization??''}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                          overflow: TextOverflow.clip,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
            context, MaterialPageRoute(builder: (context)=> DoctorInfoScreen(doctor: doctor,))
          );
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


// child: StreamBuilder(
                      //     stream: _databaseReference.onChildChanged,
                      //     builder: (context, snap) {
                      //       // List<Doctor>? allDoctors =  snapshot.data;
 
                      //       final data = snap.data;
                      //       print(data);
                      //       // return snapshot.hasError 
                      //       // ?
                      //       //   Center(child: Text('Something went wrong'),)
                      //       // : snapshot.hasData 
                      //       //   ? ListView.builder(
                      //       //       itemCount: allDoctors!.length,
                      //       //       itemBuilder: (context,index){
                      //       //         return createDoctorWidget(
                      //       //           imgName: "doc${(index)%3 +1}.png",
                      //       //           doctor: allDoctors[index],                                
                      //       //         );
                      //       //       }
                      //       //     )
                      //       //   : Center(child: CircularProgressIndicator() );
                      //       return Text('hello ');
                      //     }
                      //   ),