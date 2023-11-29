import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hogme_user_prod/models/users.dart';

class AuthenticationService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //sign in with email also check the role of the user before sign in
  Future<UserCredential> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      //add some role checking here
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //logout method
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }

  Users? get currentUser {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      // Map the Firebase User to your Users model
      return Users(
        id: user.uid,
        email: user.email ?? '',
        firstname: '',
        lastname: '',
        contactnumber: '',
        profilepicture: '',
        facilitypicture: '',
        valididpicture: '',
        password: '',
        status: '',
        role: '',
        // Map other properties accordingly
      );
    }
    return null;
  }
}
