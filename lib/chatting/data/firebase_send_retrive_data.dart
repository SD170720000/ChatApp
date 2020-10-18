import 'package:cloud_firestore/cloud_firestore.dart';


Future<void> sendMessage(String text) async {
  Map<String,dynamic> demoData = {'message':text,'time':Timestamp.now()};

  CollectionReference datacollectionReference = FirebaseFirestore.instance.collection('data');
  datacollectionReference.add(demoData);
  return;
}

retriveMessage(){
 return FirebaseFirestore.instance.collection('data').orderBy('time',descending: true).snapshots();
}