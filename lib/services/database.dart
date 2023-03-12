import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");

  DatabaseService({this.uid});

  Future updateUserData(String name, String email) async {
    return await userCollection.doc(uid).set({
      "fullName": name,
      "email": email,
      "groups": [],
      "uid": uid,
    });
  }
}
