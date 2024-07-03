import "package:app/src/firebase/auth.dart";
import "package:app/src/pages/home_view.dart";
import "package:app/src/pages/register_view.dart";
import "package:app/src/providers/user_provider.dart";
import "package:app/src/utils/constants.dart";
import "package:app/src/utils/theme.dart";
import "package:app/src/widgets/text_field_input.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static const routeName = "/login";

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with TickerProviderStateMixin {
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  bool _isLoading = false;

  late AnimationController progressController;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    progressController.dispose();
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    super.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });

    await Auth()
        .login(
            email: emailTextEditingController.text,
            password: passwordTextEditingController.text)
        .then((value) async {
      if (value == "Success") {
        await Provider.of<UserProvider>(context, listen: false).refreshUser();
        WidgetsBinding.instance.addPostFrameCallback((_) =>
            Navigator.pushNamedAndRemoveUntil(
                context, HomeView.routeName, (route) => false));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(value),
        ));
      }
    });

    setState(() {
      _isLoading = false;
    });
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
          return loginPage();
        });
  }

  Scaffold loginPage() {
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < responsiveSizeThreshold) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login to",
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
              loginCredentials(constraints),
              Padding(
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
                          child: Text("Don't have an account?",
                              style: cumuloTheme.textTheme.displaySmall
                                  ?.copyWith(fontSize: 14)),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12.0, 12, 12, 0),
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
                                  context, RegisterView.routeName);
                            },
                            child: const SizedBox(
                                width: 80,
                                height: 30,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Register"),
                                  ],
                                )),
                          ),
                        ),
                        SizedBox(height: constraints.maxHeight * 0.03),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Text("Desktop view");
        }
      }),
    );
  }

  Container loginCredentials(BoxConstraints constraints) {
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
                    SizedBox(height: constraints.maxHeight * 0.05),
                    TextFieldInput(
                        textEditingController: passwordTextEditingController,
                        hintText: "Password",
                        isPassword: true,
                        textInputType: TextInputType.visiblePassword),
                    SizedBox(height: constraints.maxHeight * 0.03),
                    _isLoading
                        ? LinearProgressIndicator(
                            value: progressController.value)
                        : TextButton(
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
                                loginUser();
                              });
                            },
                            child: const SizedBox(
                                width: 80,
                                height: 30,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Login"),
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
}
