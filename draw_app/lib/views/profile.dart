import 'package:draw_app/views/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () async {
              await auth.signOut();
              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10, // replace with your list of orders
        itemBuilder: (context, index) {
          return Slidable(
            key: Key(index.toString()),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              extentRatio: 0.25,
              children: [
                // A SlidableAction can have an icon and/or a label.
                SlidableAction(
                  onPressed: (context) {
                    // try {
                    //   Database().deleteAppData(userId, document.id);
                    //   ScaffoldMessenger.of(context)
                    //       .showSnackBar(MySnackBar(text: 'delete: SUCCESS').get());
                    // } catch (e) {
                    //   ScaffoldMessenger.of(context)
                    //       .showSnackBar(MySnackBar(text: 'delete: FAILED').get());
                    // }
                  },
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            child: const Card(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'title',
                        // document.data()['content'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
