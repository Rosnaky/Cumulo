import "package:app/src/firebase/auth.dart";
import "package:app/src/pages/home_view.dart";
import 'package:app/src/pages/splash_view.dart';
import "package:app/src/pages/login_view.dart";
import "package:app/src/utils/constants.dart";
import "package:app/src/utils/theme.dart";
import "package:app/src/widgets/text_field_input.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  static const routeName = "/register";

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView>
    with TickerProviderStateMixin {
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final TextEditingController firstNameTextEditingController =
      TextEditingController();
  final TextEditingController lastNameTextEditingController =
      TextEditingController();
  final TextEditingController confirmPasswordTextEditingController =
      TextEditingController();

  late AnimationController progressController;

  bool _isLoading = false;
  DateTime? _dateOfBirth;
  int _step = 0;
  var months = {
    1: "January",
    2: "February",
    3: "March",
    4: "April",
    5: "May",
    6: "June",
    7: "July",
    8: "August",
    9: "September",
    10: "October",
    11: "November",
    12: "December"
  };

  @override
  void initState() {
    super.initState();

    progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    progressController.repeat();
  }

  @override
  void dispose() {
    progressController.dispose();
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    confirmPasswordTextEditingController.dispose();
    firstNameTextEditingController.dispose();
    lastNameTextEditingController.dispose();
    _step = 0;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) =>
                Navigator.pushNamedAndRemoveUntil(
                    context, HomeView.routeName, (route) => false));
          }
          return Scaffold(
            appBar: AppBar(),
            body: LayoutBuilder(builder: (context, constraints) {
              if (constraints.maxWidth < responsiveSizeThreshold) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Register with",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(fontWeight: FontWeight.w300),
                    ),
                    Text(
                      "Cumulo",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: cumuloTheme.colorScheme.primary),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.1),
                    registerWidget(constraints),
                    _step == 0
                        ? Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              width: constraints.maxWidth * 0.9,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: cumuloTheme.colorScheme.primary,
                                  )),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10.0, 10, 10, 0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text("Already have an account?",
                                          style: cumuloTheme
                                              .textTheme.displaySmall
                                              ?.copyWith(fontSize: 14)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          12.0, 12, 12, 0),
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, LoginView.routeName);
                                        },
                                        child: const SizedBox(
                                            width: 80,
                                            height: 30,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text("Login"),
                                              ],
                                            )),
                                      ),
                                    ),
                                    SizedBox(
                                        height: constraints.maxHeight * 0.03),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                );
              } else {
                return const Text("Desktop view");
              }
            }),
          );
        });
  }

  Container registerWidget(BoxConstraints constraints) {
    switch (_step) {
      case 0:
        return registerEmailAndPassword(constraints);
      case 1:
        return registerName(constraints);
      default:
        return registerEmailAndPassword(constraints);
    }
  }

  Container registerEmailAndPassword(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cumuloTheme.colorScheme.primary),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SizedBox(
                width: constraints.maxWidth * 0.8,
                child: Column(
                  children: [
                    TextFieldInput(
                        textEditingController: emailTextEditingController,
                        hintText: "Email",
                        textInputType: TextInputType.emailAddress),
                    SizedBox(height: constraints.maxHeight * 0.03),
                    TextFieldInput(
                        textEditingController: passwordTextEditingController,
                        hintText: "Password",
                        isPassword: true,
                        textInputType: TextInputType.visiblePassword),
                    SizedBox(height: constraints.maxHeight * 0.03),
                    TextFieldInput(
                        textEditingController:
                            confirmPasswordTextEditingController,
                        hintText: "Confirm Password",
                        isPassword: true,
                        textInputType: TextInputType.visiblePassword),
                    SizedBox(height: constraints.maxHeight * 0.03),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.primary,
                        backgroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _step = 1;
                        });
                      },
                      child: const SizedBox(
                          width: 80,
                          height: 30,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Next"),
                            ],
                          )),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.03),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container registerName(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cumuloTheme.colorScheme.primary),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SizedBox(
                width: constraints.maxWidth * 0.8,
                child: Column(
                  children: [
                    TextFieldInput(
                        textEditingController: firstNameTextEditingController,
                        hintText: "First Name",
                        textInputType: TextInputType.emailAddress),
                    SizedBox(height: constraints.maxHeight * 0.03),
                    TextFieldInput(
                        textEditingController: lastNameTextEditingController,
                        hintText: "Last Name",
                        textInputType: TextInputType.visiblePassword),
                    SizedBox(height: constraints.maxHeight * 0.03),
                    SizedBox(
                      child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor:
                                Theme.of(context).colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900, 1, 1),
                                    lastDate: DateTime.now())
                                .then((value) => {
                                      setState(() => _dateOfBirth = value),
                                    });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_today),
                                const SizedBox(width: 10),
                                Text(
                                    _dateOfBirth == null
                                        ? "Date of Birth"
                                        : "${months[_dateOfBirth?.month]} ${_dateOfBirth?.day}, ${_dateOfBirth?.year}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(fontSize: 16))
                              ],
                            ),
                          )),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.03),
                    _isLoading
                        ? LinearProgressIndicator(
                            value: progressController.value)
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor:
                                        Theme.of(context).colorScheme.primary,
                                    backgroundColor:
                                        Theme.of(context).colorScheme.onPrimary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _step = 0;
                                    });
                                  },
                                  child: const SizedBox(
                                      width: 80,
                                      height: 30,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Previous"),
                                        ],
                                      )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor:
                                        Theme.of(context).colorScheme.primary,
                                    backgroundColor:
                                        Theme.of(context).colorScheme.onPrimary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    // Register user
                                    register();
                                  },
                                  child: const SizedBox(
                                      width: 80,
                                      height: 30,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Submit"),
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(height: constraints.maxHeight * 0.03),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  register() async {
    setState(() {
      _isLoading = true;
    });

    Auth()
        .register(
      email: emailTextEditingController.text,
      password: passwordTextEditingController.text,
      firstName: firstNameTextEditingController.text,
      lastName: lastNameTextEditingController.text,
      dateOfBirth: _dateOfBirth,
    )
        .then((value) {
      setState(() {
        _isLoading = false;
      });
      if (value == "Success") {
        Navigator.pushNamed(context, SplashView.routeName);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(value),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    });
  }
}
