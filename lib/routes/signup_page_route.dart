import 'package:flutter/material.dart';
import 'package:therapist_side/exclusive_widgets/login_signup_button.dart';

import '../utils/authentication.dart';

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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 100),
              const Text(
                "PHYZZICARE",
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 100),
              Expanded(
                child: Center(
                  child: Text(
                    "Being patient can be hard sometimes.\nBut no more suffering.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: MediaQuery.of(context).size.height * 0.03,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
                child: FutureBuilder(
                  future: Authentication.initializerFirebase(context: context),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text("Error initializing Firebase");
                    } else if (snapshot.connectionState == ConnectionState.done) {
                      return const LoginSignUpButton();
                    }
                    return CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.primaryContainer,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
