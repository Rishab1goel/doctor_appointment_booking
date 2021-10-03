
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';


class FirebaseRealtimeDataService {
  static DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();

  static Future write({required String path, required Map<String, dynamic> jsonData}) async {
    try {
      await _databaseReference.child(path).set(
        jsonData
      );
    } on Exception catch (e) {
      log('FirebaseRealtimeData write error: $e');
    }
  }

  static Future read() async {
    try {
      Map<Object?,Object?> data;
      data = await  _databaseReference.once().then((DataSnapshot snapshot) {
        // print('Data : ${snapshot.value}');
        return snapshot.value;
      });
      return data;
    } on Exception catch (e) {
      log('FirebaseRealtimeData read error: $e');
    }
  }

  static Future update({required String path, required Map<String,dynamic> jsonData}) async {
    try {
      await _databaseReference.child(path).update(jsonData);
    } on Exception catch (e) {
      log('FirebaseRealtimeData update error: $e');
    }
  }

  static Future delete({required String path}) async {
    try {
      await _databaseReference.child(path).remove();
    } on Exception catch (e) {
      log('FirebaseRealtimeData delete error: $e');
    }
  }
}
