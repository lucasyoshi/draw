import 'package:draw_app/models/order.dart';
import 'package:draw_app/services/database.dart';
import 'package:draw_app/services/orders.dart';
import 'package:draw_app/views/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  var userModel;
  Future<List<UserOrder>>? orders;
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    userModel = Database().getUser(user!.uid);
    orders = Cart().getAllUserOrders(user!.uid);
  }

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
      body: FutureBuilder<List<UserOrder>>(
        future: orders, // replace with your method
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                UserOrder order = snapshot.data![index];
                return Slidable(
                    key: Key(order.id),
                    startActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      extentRatio: 0.25,
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            // Add your delete logic here.
                          },
                          backgroundColor: const Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: Expanded(
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Order ID: ${order.id}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Date: ${DateFormat('yyyy-MM-dd').format(order.date)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Items: ${order.items.length}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ));
              },
            );
          } else {
            return const Center(
              child: Text('No orders found.'),
            );
          }
        },
      ),
    );
  }
}
