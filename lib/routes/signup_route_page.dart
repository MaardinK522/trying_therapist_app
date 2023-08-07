import 'package:flutter/material.dart';
import 'package:therapist_side/utils/constant_dims.dart';

import '../gen/assets.gen.dart';
import '../routes/home_page_route.dart';

class SignupPageRoute extends StatelessWidget {
  const SignupPageRoute({super.key});

  @override
  Widget build(BuildContext context) {
    var iconSize = 25.0;
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
                obscureText: true,
                autofillHints: const [AutofillHints.password],
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    style: const ButtonStyle(
                        splashFactory:
                            InkSparkle.constantTurbulenceSeedSplashFactory),
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
              const SizedBox(height: 30),
              const Expanded(
                child: Center(
                  child: Text(
                    "--- Or ---",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {},
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: Constants.textFieldBorderRadius,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Image.asset(
                              Assets.images.facebook.path,
                              fit: BoxFit.fill,
                              height: iconSize + 10,
                              width: iconSize + 10,
                            ),
                            const Expanded(
                              child: Text(
                                "FaceBook",
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    customBorder: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.blue, width: 2),
                    ),
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {},
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: Constants.textFieldBorderRadius,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Image.asset(
                              Assets.images.google.path,
                              fit: BoxFit.fill,
                              height: iconSize + 10,
                              width: iconSize + 10,
                            ),
                            const Expanded(
                              child: Text(
                                "Google",
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => const MyHomePage(),
                          ),
                        );
                      },
                      child: const Text("Login"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
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
                      onPressed: () {},
                      child: const Text("Signup"),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
