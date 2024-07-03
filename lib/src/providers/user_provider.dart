import 'package:app/src/firebase/auth.dart';
import 'package:app/src/models/firebase_user.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  FirebaseUser? _user;
  final Auth _auth = Auth();

  FirebaseUser? get user => _user;

  Future<void> refreshUser() async {
    _user = await _auth.getUserDetails();
    notifyListeners();
  }
}
