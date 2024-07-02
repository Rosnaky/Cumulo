import 'package:app/src/pages/home_view.dart';
import 'package:app/src/pages/login_view.dart';
import 'package:app/src/utils/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app/src/utils/constants.dart' as constants;

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  static const routeName = "/";

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          return Scaffold(
            body: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < constants.responsiveSizeThreshold) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Welcome to",
                                overflow: TextOverflow.visible,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(fontWeight: FontWeight.w300)),
                            Text("Cumulo",
                                overflow: TextOverflow.visible,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color:
                                            cumuloTheme.colorScheme.primary)),
                            SizedBox(height: height * 0.05),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                child: SizedBox.fromSize(
                                    size: Size(width * 0.9, height * 0.25),
                                    child: const Image(
                                        image: AssetImage(
                                            "assets/images/login_image.png"))),
                              ),
                            ),
                            SizedBox(height: height * 0.05),
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  "A bubbly way to manage all of your gliding navigation, club, and pilot needs",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.15),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context,
                                      snapshot.hasData
                                          ? HomeView.routeName
                                          : LoginView.routeName);
                                },
                                child: snapshot.hasData
                                    ? const Text("Enter")
                                    : const Text("Login"))
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Text("Desktop View");
                }
              },
            ),
          );
        });
  }
}
