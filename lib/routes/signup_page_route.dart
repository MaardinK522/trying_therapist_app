import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:therapist_side/routes/login_route_page.dart';

import '../utils/constant_dims.dart';

class SignupPageRoute extends StatefulWidget {
  const SignupPageRoute({super.key});

  @override
  State<SignupPageRoute> createState() => _SignupPageRouteState();
}

class _SignupPageRouteState extends State<SignupPageRoute> {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController againPasswordTextController = TextEditingController();

  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    IconData visibilityIcon = (!isHidden) ? Icons.visibility_rounded : Icons.visibility_off_rounded;
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
                obscureText: isHidden,
                obscuringCharacter: '*',
                autofillHints: const [AutofillHints.password],
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    style: const ButtonStyle(splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory),
                    onPressed: () {
                      _changePasswordVisibility();
                    },
                    icon: Icon(visibilityIcon),
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
              const SizedBox(height: 20),
              TextFormField(
                obscuringCharacter: '*',
                controller: againPasswordTextController,
                obscureText: isHidden,
                autofillHints: const [AutofillHints.password],
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    style: const ButtonStyle(splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory),
                    onPressed: () {
                      _changePasswordVisibility();
                    },
                    icon: Icon(visibilityIcon),
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
                  hintText: "Confirm Password",
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
                            MaterialPageRoute(builder: (context) => const LoginPageRoute()),
                          );
                        },
                        child: const Text("Login"),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Hero(
                      tag: "right_widget",
                      child: FilledButton.tonal(
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
                          if (passwordTextController.text == againPasswordTextController.text) _signupUser(context);
                        },
                        child: const Text("Signup"),
                      ),
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

  _changePasswordVisibility() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  void _signupUser(context) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );
      var sharedpref = await SharedPreferences.getInstance();
      sharedpref.setString("user_email", emailTextController.text);
      sharedpref.setString("user_acc_pass", passwordTextController.text);
      Fluttertoast.showToast(msg: 'Account registered successfully.');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
        Fluttertoast.showToast(msg: 'The password provided is too weak.');
        return;
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
        Fluttertoast.showToast(msg: 'The account already exists for that email.');
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (ctx) => const LoginPageRoute(),
      ),
    );
  }
}
