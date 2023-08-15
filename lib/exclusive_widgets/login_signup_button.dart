// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:therapist_side/routes/home_page_route.dart';
import 'package:therapist_side/utils/authentication.dart';

import '../gen/assets.gen.dart';

class LoginSignUpButton extends StatefulWidget {
  const LoginSignUpButton({super.key});

  @override
  State<LoginSignUpButton> createState() => _LoginSignUpButtonState();
}

class _LoginSignUpButtonState extends State<LoginSignUpButton> {
  bool _signingIn = false;

  @override
  Widget build(BuildContext context) {
    return _signingIn
        ? const Center(child: CircularProgressIndicator())
        : Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () async {
                setState(() {
                  _signingIn = true;
                });
                User? user = await Authentication.signInWithGoogle(context: context);
                setState(() {
                  _signingIn = true;
                });
                if (user != null) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const MyHomePage()),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Assets.images.google.image(
                      fit: BoxFit.fill,
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.height * 0.05,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                    ),
                    Text(
                      "GOOGLE",
                      style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.075),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
