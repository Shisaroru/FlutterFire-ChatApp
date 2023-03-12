import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myproject_app/services/database.dart';

class Auth {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final firebaseAuth = FirebaseAuth.instance;

  Future<String> googleSignIn() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return "Something went wrong. Please try again";

      final googleAuth = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      User? user =
          (await firebaseAuth.signInWithCredential(authCredential)).user;

      if (user == null) {
        return "Something went wrong. Please try again";
      } else {
        QuerySnapshot snapshot =
            await DatabaseService(uid: user.uid).getUser(user.email!);

        if (snapshot.size == 0) {
          DatabaseService(uid: user.uid)
              .updateUserData(user.displayName!, user.email!);
        }
        return "";
      }
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }

  Future<String> signIn(String email, String password) async {
    try {
      User? user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;

      if (user == null) {
        return "Something went wrong. Please try again";
      }

      return "";
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }

  Future<String> register(String name, String email, String password) async {
    try {
      User? user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;

      if (user != null) {
        DatabaseService(uid: user.uid).updateUserData(name, email);
      }
      return "";
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
