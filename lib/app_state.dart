import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myproject_app/services/auth.dart';
import 'package:myproject_app/services/database.dart';

class AppState extends ChangeNotifier {
  String _name = "";

  String get name => _name;

  void getName() async {
    var email = Auth().firebaseAuth.currentUser?.email;
    QuerySnapshot snapshot =
        await DatabaseService(uid: Auth().firebaseAuth.currentUser?.uid)
            .getUser(email!);
    _name = snapshot.docs[0]["fullName"];
    notifyListeners();
  }
}
