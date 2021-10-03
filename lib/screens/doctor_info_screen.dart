import 'package:doctorappointmentbookingapp/colorScheme.dart';
import 'package:doctorappointmentbookingapp/models/doctor.dart';
import 'package:doctorappointmentbookingapp/screens/get_started_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DoctorInfoScreen extends StatefulWidget {
  static const String title = 'doctorInfoScreen';
  final Doctor doctor;

  const DoctorInfoScreen({Key? key,required this.doctor}) : super(key: key);
  
  @override
  _DoctorInfoScreenState createState() => _DoctorInfoScreenState();
}

class _DoctorInfoScreenState extends State<DoctorInfoScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [getStartedColorStart,getStartedColorEnd],
            begin: Alignment(0,-1.15),
            end: Alignment(0,0.1),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.4,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Image.asset('assets/bg1.png'),

              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.6,
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
                                  "Dr. ${widget.doctor.name}",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  "${widget.doctor.specialization}",
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
                        padding: EdgeInsets.only(left: 8,right: 8),
                        child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 20,),
                          Text("About the doctor",style: TextStyle(fontSize: 20,fontWeight:FontWeight.w800),),
                          SizedBox(height: 10,),
                          Text("${widget.doctor.description}",
                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),
                          SizedBox(height: 24,),
                          Text("Available time slots",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800),),
                          SizedBox(height: 5,),
                          timeSlotWidget("13","May","Consultation","Sunday 9 am to 1.30 am"),
                          timeSlotWidget("14","May","Consultation","Monday 10 am to 1.30 am"),
                          timeSlotWidget("1","June","Consultation","Wednesday 9 am to 1.30 am"),
                          timeSlotWidget("3","June","Consultation","Friday 10 am to 1.30 am"),
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
  Container timeSlotWidget(String date,String month,String slotType,String time){

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: docContentBgColor
      ),
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
                  Text("$date",style: TextStyle(
                    color:dateColor,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),),
                  Text("$month",style: TextStyle(color: dateColor,fontSize: 20,fontWeight: FontWeight.w800),),

                ],
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$slotType",style: TextStyle(color: dateColor,fontSize: 20,fontWeight: FontWeight.w800),),
                  Text("$time",style: TextStyle(color: dateColor,fontSize: 17,fontWeight: FontWeight.w600),),
            
                ],
            
              ),
            ),
          ],
        ),
      ),
    );
  }

}

