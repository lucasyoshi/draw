import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String id;
  late String name;
  late String? email;
  late bool? signedInWithGoogle;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.signedInWithGoogle,
  });

  UserModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    name = documentSnapshot["name"];
    email = documentSnapshot["email"];
    signedInWithGoogle = documentSnapshot["signedInWithGoogle"];
    print('UserModel.fromDocumentSnapshot: name= $name');
  }
}
