import "package:app/src/widgets/text_field_input.dart";
import "package:flutter/material.dart";

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static const routeName = "/login";

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                  image: AssetImage("assets/images/login_image.png"),
                  width: 900),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              loginCredentials(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: const Color.fromARGB(255, 138, 131, 131)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text("Don't have an account?"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  const Color.fromARGB(255, 0, 90, 163),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, "/register");
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
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container loginCredentials() {
    return Container(
      width: 400,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color.fromARGB(255, 138, 131, 131)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 400,
              child: Column(
                children: [
                  TextFieldInput(
                      textEditingController: emailTextEditingController,
                      hintText: "Email",
                      textInputType: TextInputType.emailAddress),
                  const SizedBox(height: 20),
                  TextFieldInput(
                      textEditingController: passwordTextEditingController,
                      hintText: "Password",
                      textInputType: TextInputType.visiblePassword),
                  const SizedBox(height: 20),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 0, 90, 163),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _isLoading = true;
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
