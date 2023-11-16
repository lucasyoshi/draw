import 'package:draw_app/services/auth.dart';
import 'package:draw_app/views/login.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  final bool useDissmissible = false;
  final Auth auth = Auth();
  final TextEditingController textEditingController = TextEditingController();

    Future<void> _handleSignOut() async {
    try {
      await auth.logOut();
      // Navigate back to the login page after successful sign out
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
      );
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Home build:');
    String currentUserId = (auth.authInst.currentUser == null
        ? ''
        : auth.authInst.currentUser!.uid);
    String? currentUserName = (auth.authInst.currentUser == null
        ? ''
        : auth.authInst.currentUser!.displayName);

    return Scaffold(
      appBar: AppBar(
        title: Text('user: $currentUserName'),
         actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _handleSignOut,
          ),
        ],
      )
    );
  }
}
