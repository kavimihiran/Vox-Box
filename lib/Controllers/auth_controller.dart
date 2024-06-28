import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Models/user.dart';
import '../Services/firebase_services.dart';

class AuthController extends ChangeNotifier {
  final FirebaseService _firebaseService;

  UserModel? _user;
  UserModel? get user => _user;

  AuthController(this._firebaseService);

  Future<void> signInWithGoogle() async {
    User? user = await _firebaseService.signInWithGoogle();
    if (user != null) {
      _user = UserModel.fromFirebaseUser(user);
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _firebaseService.signOut();
    _user = null;
    notifyListeners();
  }
}
