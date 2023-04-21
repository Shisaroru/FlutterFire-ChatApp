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

  Stream<QuerySnapshot> getChats(String groupId) {
    return groupCollection
        .doc(groupId)
        .collection("messages")
        .orderBy("time", descending: true)
        .snapshots();
  }

  Future getGroupMembers(String groupId) async {
    DocumentReference doc = groupCollection.doc(groupId);
    DocumentSnapshot snapshot = await doc.get();
    List members = await snapshot.get("members");
    List membersList = [];
    String admin = await snapshot.get("admin");
    for (var i = 0; i < members.length; i++) {
      DocumentReference userDoc = userCollection.doc(members[i]);
      DocumentSnapshot userSnapshot = await userDoc.get();
      if (members[i] == admin) {
        admin = userSnapshot.get("fullName");
      }
      membersList.add(userSnapshot.get("fullName"));
    }
    return [...membersList, admin];
  }

  Future searchGroupByName(String groupName) async {
    return groupCollection.where("groupName", isEqualTo: groupName).get();
  }

  Future<bool> isJoinedGroup(String groupId, String groupName) async {
    DocumentReference userDoc = userCollection.doc(uid);
    DocumentSnapshot userSnapshot = await userDoc.get();

    List groups = userSnapshot.get("groups");
    if (groups.contains("${groupId}_$groupName")) {
      return true;
    }
    return false;
  }

  Future toggleJoinGroup(String groupId, String groupName) async {
    DocumentReference userDoc = userCollection.doc(uid);
    DocumentReference groupDoc = groupCollection.doc(groupId);

    DocumentSnapshot userSnapshot = await userDoc.get();

    List groups = userSnapshot.get("groups");

    if (groups.contains("${groupId}_$groupName")) {
      await userDoc.update({
        "groups": FieldValue.arrayRemove(["${groupId}_$groupName"]),
      });
      await groupDoc.update({
        "members": FieldValue.arrayRemove([uid])
      });
    } else {
      await userDoc.update({
        "groups": FieldValue.arrayUnion(["${groupId}_$groupName"]),
      });
      await groupDoc.update({
        "members": FieldValue.arrayUnion([uid])
      });
    }
  }

  Future sendMessage(String groupId, Map<String, dynamic> chatMessage) async {
    groupCollection.doc(groupId).collection("messages").add(chatMessage);
    groupCollection.doc(groupId).update({
      "recentMessage": chatMessage['message'],
      "recentMessageSender": chatMessage['sender'],
      "recentMessageTime": chatMessage['time'].toString(),
    });
  }
}
