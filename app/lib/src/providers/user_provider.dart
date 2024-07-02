import 'package:app/src/firebase/auth.dart';
import 'package:app/src/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final Auth _auth = Auth();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    _user = await _auth.getUserDetails();
    notifyListeners();
  }
}
