import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthRepository extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  User? user;
  bool loading = true;

  AuthRepository() {
    _auth.authStateChanges().listen((u) async {
      if (u != null) {
        await u.reload();
        user = _auth.currentUser;
      } else {
        user = null;
      }

      loading = false;
      notifyListeners();
    });
  }

  Future<String?> login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> register(String email, String senha) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
