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
import 'package:intl/intl.dart';

class HomeScreenDoctor extends StatefulWidget {
  static const String title = 'homeScreenDoctor';
  @override
  _HomeScreenDoctorState createState() => _HomeScreenDoctorState();
}

class _HomeScreenDoctorState extends State<HomeScreenDoctor> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  var _databaseReference = FirebaseDatabase.instance.reference();
  bool _isConnected = false;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();


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
                  InkWell(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Color(0xff54D579).withOpacity(0.5),
                      child: Icon(
                        Icons.perm_identity_rounded,
                        size:40,
                        color: Color(0xff353538),
                      ),
                    ),
                    onTap: (){
                      Navigator.pushNamed(context, DoctorProfileScreen.title);
                    },
                  )
            
              ],
            ),
            body: Padding(
              padding: EdgeInsets.only(left: 20, right: 10, top: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Categories",
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

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your Available Slots",
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
                              child: ListView(
                                children: [
                                  timeSlotWidget("13","May","Consultation","Sunday 9 am to 1.30 am"),
                                  timeSlotWidget("14","May","Consultation","Monday 10 am to 1.30 am"),
                                  timeSlotWidget("1","June","Consultation","Wednesday 9 am to 1.30 am"),
                                  timeSlotWidget("3","June","Consultation","Friday 10 am to 1.30 am"),
                                ],
                              )
                            )
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            floatingActionButton: Container(
              height: 70,
              width: 70,
              child: FloatingActionButton(
                onPressed: ()async{
                  await _selectDate(context);
                },
                child: Icon(Icons.add, size: 40,),
              ),
            ),
          ),
        ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    selectedDate = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101)
    );
    if (pickedDate != null){
      selectedTime = TimeOfDay.now();
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context, 
        initialTime: selectedTime
      );
      if (pickedTime != null) {
        setState(() {
          selectedTime = pickedTime;
          selectedDate = pickedDate;
        });
        await _databaseReference.child('doctors/${_auth.currentUser!.uid}/slots').push().set(
          {
            'date': '$selectedDate',
            'time': '${selectedTime.hour}:${selectedTime.minute}',
          }
        );
        print('slot added');
      }
    }
    
    log('${selectedDate}');
    // log('${selectedDate.day}');
    // log('${selectedDate.weekday}');

    log('${selectedTime}');
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

 

  Container timeSlotWidget(
      String date, String month, String slotType, String time) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: docContentBgColor),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Container(
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: dateBgColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "$date",
                    style: TextStyle(
                      color: dateColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "$month",
                    style: TextStyle(
                        color: dateColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$slotType",
                    style: TextStyle(
                        color: dateColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                  Text(
                    "$time",
                    style: TextStyle(
                        color: dateColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
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
