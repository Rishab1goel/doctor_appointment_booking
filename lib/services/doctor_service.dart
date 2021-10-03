
import 'dart:developer';

import 'package:doctorappointmentbookingapp/models/doctor.dart';
import 'package:doctorappointmentbookingapp/services/firebase_realtime_database_service.dart';
import 'package:firebase_database/firebase_database.dart';



class DoctorService{

  static Doctor? currentDoctor;
    static DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();

  // Fetching Doctors from realtime database
  static Stream <List<Doctor>?> fetchDoctors()async*{
    try{
      final data = await FirebaseRealtimeDataService.read();
      log('data = $data');
      if(data!=null){
        List<Doctor> doctors = data['doctors'].entries.map<Doctor>((entry){
          return Doctor.formJson(entry.value);
        }).toList();
        yield doctors;
      }

    }catch(e){
      log('fetchDoctors exception: $e');
    }
  }


  // static Future<List<Doctor>?> fetchDoctors2() async {
  //   try {
  //     final data = await FirebaseRealtimeDataService.read();
  //     // log('data = $data');

  //     List<Doctor> doctors = data['doctors'].entries.map<Doctor>((entry) {
  //       return Doctor.formJson(entry.value);
  //     }).toList();
  //     return doctors;
  //   } catch (e) {
  //     log('fetchDoctors exception: $e');
  //   }
  // }

  static Future<Doctor?> setCurrentDoctor({required String uid}) async {
    try {
      final data = await FirebaseRealtimeDataService.read();
      // log('data = $data');
      // print( Doctor.formJson(data['doctors'][uid]).name);
      currentDoctor = Doctor.formJson(data['doctors'][uid]);
    } catch (e) {
      log('fetchDoctors exception: $e');
    }
  }
}