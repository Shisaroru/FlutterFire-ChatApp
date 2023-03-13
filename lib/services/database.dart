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

  Future getUser(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  getUserGroup() {
    return userCollection.doc(uid).snapshots();
  }

  Future createGroup(String id, String groupName) async {
    DocumentReference documentReferences = await groupCollection.add({
      "groupName": groupName,
      "admin": id,
      "members": [],
      "groupId": "",
      "recentMessage": "",
      "recentMessageSender": "",
    });

    await documentReferences.update({
      "members": FieldValue.arrayUnion([id]),
      "groupId": documentReferences.id,
    });

    DocumentReference userDocument = userCollection.doc(id);
    return await userDocument.update({
      "groups": FieldValue.arrayUnion(["${documentReferences.id}_$groupName"]),
    });
  }
}
