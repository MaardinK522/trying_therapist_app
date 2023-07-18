import 'package:flutter/material.dart';
import 'package:therapist_side/generated/assets.dart';
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 100),
                const Text(
                  "Signup",
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 70),
                TextFormField(
                  autofillHints: const [AutofillHints.email],
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 2,
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                      ),
                      hintText: "Email"),
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
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 2,
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                    ),
                    hintText: "Password",
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  "------ Or ------",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {},
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Image.asset(
                            Assets.facebook,
                            fit: BoxFit.fill,
                            height: iconSize + 10,
                            width: iconSize + 10,
                          ),
                          Expanded(
                            child: Text(
                              "FaceBook",
                              style: TextStyle(fontSize: iconSize - 6),
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
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Image.asset(
                            Assets.google,
                            fit: BoxFit.fill,
                            height: iconSize + 10,
                            width: iconSize + 10,
                          ),
                          Expanded(
                            child: Text(
                              "Google",
                              style: TextStyle(fontSize: iconSize - 5),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.tonal(
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
                        onPressed: () {},
                        child: const Text("Signup"),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
