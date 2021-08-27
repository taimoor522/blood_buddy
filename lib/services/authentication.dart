import 'package:blood_buddy/services/fire_store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Authentication {
  final _authInstance = FirebaseAuth.instance;

  static final Authentication _auth = Authentication._internal();

  factory Authentication() {
    return _auth;
  }

  Authentication._internal();

  Future<UserCredential> signIn(String email, String password) async {
    try {
      var user = await _authInstance.signInWithEmailAndPassword(
          email: email, password: password);
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'User Not Found');
        throw (e);
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Wrong Password');
        throw (e);
      }
    }
    throw ('');
  }

  Future<UserCredential> signUp(String email, String password, String name,
      String phone, String city, String bg) async {
    try {
      var user = await _authInstance.createUserWithEmailAndPassword(
          email: email, password: password);

      await Database(uid: user.user!.uid).addUserData(
          email: email,
          fullName: name,
          phone: phone,
          bloodGroup: bg,
          city: city);
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'Try Strong Password');
        throw (e);
      }
    }

    throw ('');
  }

  Future<bool> isUserExist(String email) async {
    var method = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
    if (method.isEmpty) return false;
    return true;
  }
}
