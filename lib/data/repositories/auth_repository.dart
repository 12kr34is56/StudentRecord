
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

   Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // Handle exceptions
      return null;
    }
  }

   Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // Handle exceptions
      return null;
    }
  }

   Future<void> signOut() async {
    await _auth.signOut();
  }

   User? getCurrentUser() {
    return _auth.currentUser;
  }

   Future<void> sendEmailVerificationLink() async {
    await _auth.currentUser!.sendEmailVerification();
  }
}