// ignore_for_file: use_build_context_synchronously, use_key_in_widget_constructors, avoid_print

import 'package:draw_app/theme/theme_switch.dart';
import 'package:flutter/material.dart';
import 'package:draw_app/services/auth.dart';
import 'package:draw_app/views/home.dart';

class SignUp extends StatelessWidget {
  final Auth auth = Auth();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print('SignUp build');
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: ThemeSwitch(),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Sign Up',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: "Full Name", hintText: "Full Name"),
                controller: nameController,
                cursorColor: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: "Email", hintText: "Email"),
                controller: emailController,
                cursorColor: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: "Password", hintText: "Password"),
                obscureText: true,
                controller: passwordController,
                cursorColor: Theme.of(context).colorScheme.secondary,
              ),
              Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 40.0, bottom: 20.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    child: const Text("Sign Up"),
                    onPressed: () async {
                      bool status = await auth.createUser(nameController.text,
                          emailController.text, passwordController.text, false);
                      if (status) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ),
                        );
                      }
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
