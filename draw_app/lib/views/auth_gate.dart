import 'package:draw_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:draw_app/views/home.dart';
import 'package:draw_app/views/login.dart';

class AuthGate extends StatelessWidget {
  final Auth auth = Auth();

  AuthGate({super.key});
  @override
  Widget build(BuildContext context) {
    print('Root build:');
    auth.listen();
    print('Present User = ${auth.authInst.currentUser}');
    if (auth.authInst.currentUser == null) {
      return Login();
    } else {
      return Home();
    }
  }
}