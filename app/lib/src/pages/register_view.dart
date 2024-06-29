import "package:app/src/pages/login_view.dart";
import "package:app/src/utils/constants.dart";
import "package:app/src/utils/theme.dart";
import "package:app/src/widgets/text_field_input.dart";
import "package:flutter/material.dart";

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  static const routeName = "/register";

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final TextEditingController firstNameTextEditingController =
      TextEditingController();
  final TextEditingController lastNameTextEditingController =
      TextEditingController();
  final TextEditingController dateOfBirthTextEditingController =
      TextEditingController();
  final TextEditingController confirmPasswordTextEditingController =
      TextEditingController();

  bool _isLoading = false;
  String _dateOfBirth = "Date of Birth";
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
  void dispose() {
    super.dispose();
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    confirmPasswordTextEditingController.dispose();
    firstNameTextEditingController.dispose();
    lastNameTextEditingController.dispose();
    dateOfBirthTextEditingController.dispose();
    _step = 0;
  }

  @override
  Widget build(BuildContext context) {
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
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
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
                          padding: const EdgeInsets.fromLTRB(10.0, 10, 10, 0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text("Already have an account?",
                                    style: cumuloTheme.textTheme.displaySmall
                                        ?.copyWith(fontSize: 14)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(12.0, 12, 12, 0),
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
                              SizedBox(height: constraints.maxHeight * 0.03),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          );
        } else {
          return Text("Desktop view");
        }
      }),
    );
  }

  Container registerWidget(BoxConstraints constraints) {
    switch (_step) {
      case 0:
        return registerEmailAndPassword(constraints);
      case 1:
        return registerName(constraints);
      case 2:
        return registerOtherInfo(constraints);
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right:8.0),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Previous"),
                                  ],
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left :8.0),
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
                      child: Expanded(
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
                                        setState(() => _dateOfBirth = value ==
                                                null
                                            ? "Date of Birth"
                                            : "${months[value?.month]} ${value?.day}, ${value?.year}")
                                      });
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 10),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(_dateOfBirth,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium
                                        ?.copyWith(fontSize: 16)),
                              ),
                            )),
                      ),
                    ),
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
                          _step = 2;
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

  Container registerOtherInfo(BoxConstraints constraints) {
    return Container(
      child: Text("Other Info"),
    );
  }
}
