import 'package:app/src/pages/login_view.dart';
import 'package:app/src/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  static const String routeName = '/settings';

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Navigator.pushNamedAndRemoveUntil(
            context, LoginView.routeName, (route) => false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < responsiveSizeThreshold) {
          return SafeArea(
              child: Column(
            children: [
              ElevatedButton(onPressed: logout, child: const Text("Log out"))
            ],
          ));
        } else {
          return Text("Desktop View");
        }
      }),
    );
  }
}
