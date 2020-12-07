import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class DataBase{

  final CollectionReference profList = FirebaseFirestore.instance.collection("Profile info");

  Future <void> createUserData(String startTime, String endTime, String comName,
      String eventName, String uid) async{
    return await profList.doc(uid).set(
      {
        'startTime':startTime,
        'endTime' : endTime,
        'commitee Name' : comName,
        'event Name' :eventName,

      }
    );
  }

}