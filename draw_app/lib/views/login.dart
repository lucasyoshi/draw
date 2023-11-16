import 'package:draw_app/theme/theme_switch.dart';
import 'package:flutter/material.dart';
import 'package:draw_app/views/home.dart';
import 'package:draw_app/views/signup.dart';
import 'package:draw_app/services/auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatelessWidget {
  final Auth auth = Auth();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Login({super.key});
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _handleSignIn(BuildContext context) async {
    try {
      await _googleSignIn.signIn();
      // Navigate to the Home page after successful sign in

      bool isSignedIn = await _googleSignIn.isSignedIn();
      if (isSignedIn) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Login build:');
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Stack(
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(hintText: "Email"),
                      controller: emailController,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // Add this line
                        ),
                      ),
                      controller: passwordController,
                      obscureText: true,
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 20.0),
                      child: ElevatedButton(
                        child: const Text("Log In"),
                        onPressed: () async {
                          bool status = await auth.logIn(
                              emailController.text, passwordController.text);
                          if (status) {
                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Home(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 20.0),
                        child: ElevatedButton(
                          child: const Text("Sign Up"),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUp(),
                              ),
                            );
                          },
                        )),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.login),
                        label: const Text('Sign in with Google'),
                        onPressed: () => _handleSignIn(context),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SafeArea(
                child: Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: const EdgeInsets.only(right: 15.0),
                child: const ThemeSwitch(),
              ),
            ))
          ],
        ));
  }
}
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               TextFormField(
//                 decoration: const InputDecoration(hintText: "Email"),
//                 controller: emailController,
//               ),
//               const SizedBox(
//                 height: 40,
//               ),
//               TextFormField(
//                 decoration: const InputDecoration(hintText: "Password"),
//                 controller: passwordController,
//                 obscureText: true,
//               ),
//               Container(
//                 width: double.infinity,
//                 margin: const EdgeInsets.symmetric(vertical: 20.0),
//                 child: ElevatedButton(
//                   child: const Text("Log In"),
//                   onPressed: () async {
//                     bool status = await auth.logIn(
//                         emailController.text, passwordController.text);
//                     if (status) {
//                       // ignore: use_build_context_synchronously
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => Home(),
//                         ),
//                       );
//                     }
//                   },
//                 ),
//               ),
//               ElevatedButton(
//                 child: const Text("Sign Up"),
//                 onPressed: () {
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => SignUp(),
//                     ),
//                   );
//                 },
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
