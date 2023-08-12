import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:therapist_side/routes/signup_page_route.dart';
import 'package:therapist_side/utils/constant_dims.dart';

import '../main.dart';
import '../routes/home_page_route.dart';

class LoginPageRoute extends StatefulWidget {
  const LoginPageRoute({super.key});

  @override
  State<LoginPageRoute> createState() => _LoginPageRouteState();
}

class _LoginPageRouteState extends State<LoginPageRoute> with RouteAware {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      routeObserver.subscribe(this, ModalRoute.of(context)!);
    });
    super.initState();
  }

  @override
  void didPush() {
    proceedForLogin();
    super.didPush();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 100),
              const Text(
                "PHYZZICARE",
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 70),
              TextFormField(
                controller: emailTextController,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.email],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: Constants.textFieldBorderRadius,
                    borderSide: const BorderSide(
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: Constants.textFieldBorderRadius,
                    borderSide: BorderSide(
                      width: 2,
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                  ),
                  hintText: "Email",
                  hintStyle: const TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordTextController,
                obscureText: true,
                autofillHints: const [AutofillHints.password],
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    style: const ButtonStyle(splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory),
                    onPressed: () {},
                    icon: const Icon(Icons.visibility_rounded),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: Constants.textFieldBorderRadius,
                    borderSide: const BorderSide(
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: Constants.textFieldBorderRadius,
                    borderSide: BorderSide(
                      width: 2,
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                  ),
                  hintText: "Password",
                  hintStyle: const TextStyle(fontSize: 20),
                ),
              ),
              const Expanded(child: Center()),
              // const SizedBox(height: 30),
              // const Expanded(
              //   child: Center(
              //     child: Text(
              //       "--- Or ---",
              //       textAlign: TextAlign.center,
              //       style: TextStyle(fontSize: 15),
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 30),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     InkWell(
              //       borderRadius: BorderRadius.circular(10),
              //       onTap: () {},
              //       child: Card(
              //         shape: RoundedRectangleBorder(
              //           borderRadius: Constants.textFieldBorderRadius,
              //         ),
              //         child: Padding(
              //           padding: const EdgeInsets.all(10.0),
              //           child: Row(
              //             children: [
              //               Image.asset(
              //                 Assets.images.facebook.path,
              //                 fit: BoxFit.fill,
              //                 height: iconSize + 10,
              //                 width: iconSize + 10,
              //               ),
              //               const Expanded(
              //                 child: Text(
              //                   "FaceBook",
              //                   style: TextStyle(fontSize: 20),
              //                   textAlign: TextAlign.center,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //     const SizedBox(height: 10),
              //     InkWell(
              //       customBorder: const RoundedRectangleBorder(
              //         side: BorderSide(color: Colors.blue, width: 2),
              //       ),
              //       borderRadius: BorderRadius.circular(10),
              //       onTap: () {},
              //       child: Card(
              //         shape: RoundedRectangleBorder(
              //           borderRadius: Constants.textFieldBorderRadius,
              //         ),
              //         child: Padding(
              //           padding: const EdgeInsets.all(10.0),
              //           child: Row(
              //             children: [
              //               Image.asset(
              //                 Assets.images.google.path,
              //                 fit: BoxFit.fill,
              //                 height: iconSize + 10,
              //                 width: iconSize + 10,
              //               ),
              //               const Expanded(
              //                 child: Text(
              //                   "Google",
              //                   style: TextStyle(fontSize: 20),
              //                   textAlign: TextAlign.center,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Hero(
                      tag: "left_widget",
                      child: OutlinedButton(
                        style: ButtonStyle(
                          textStyle: const MaterialStatePropertyAll(
                            TextStyle(fontSize: 20),
                          ),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const SignupPageRoute()),
                          );
                        },
                        child: const Text("Signup"),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Hero(
                      tag: "right_widget",
                      child: _loginButton,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  void _siginUser() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );
      var sharedpref = await SharedPreferences.getInstance();
      sharedpref.setString("user_email", emailTextController.text);
      sharedpref.setString("user_acc_pass", passwordTextController.text);
      Fluttertoast.showToast(msg: "Login successful.");
      _openMain();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
        Fluttertoast.showToast(
          msg: "Unable to find account details.",
          textColor: Colors.red,
        );
        return;
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
        Fluttertoast.showToast(
          msg: "Credentials are wrong",
          textColor: Colors.red,
        );
        return;
      }
    }
  }

  get _loginButton => FilledButton.tonal(
        style: ButtonStyle(
          textStyle: const MaterialStatePropertyAll(
            TextStyle(fontSize: 20),
          ),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        onPressed: () {
          _siginUser();
        },
        child: const Text("Login"),
      );

  void proceedForLogin() async {
    var sharedPref = await SharedPreferences.getInstance();
    String? email = sharedPref.getString("user_email");
    String? password = sharedPref.getString("user_acc_pass");
    if (email != null && password != null) _siginUser();
  }

  void _openMain() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (ctx) => const MyHomePage(),
      ),
    );
  }
}
