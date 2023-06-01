import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

// log in
  Future logIn(String email, String password) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      print(e);
      return null;
    }
  }
// register
}
