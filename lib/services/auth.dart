import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myproject_app/services/database.dart';

class Auth {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final firebaseAuth = FirebaseAuth.instance;

  Future<String?> googleSignIn() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return "Something went wrong. Please try again";

      final googleAuth = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(authCredential);
      return "";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> signIn() async {
    try {
      return "";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> register(String name, String email, String password) async {
    try {
      User? user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;

      if (user != null) {
        DatabaseService(uid: user.uid).updateUserData(name, email);
      }
      return "";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
