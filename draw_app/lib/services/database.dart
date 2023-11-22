import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draw_app/models/user.dart';

class Database {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<bool> createNewUser(UserModel user) async {
    print('Database createNewUser: try');
    try {
      await db.collection("users").doc(user.id).set({
        "name": user.name,
        "email": user.email,
        "signedInWithGoogle": user.signedInWithGoogle,
      });
      return true;
    } catch (e) {
      print('Database createNewUser: catch $e');
      return false;
    }
  }
    Future<String> getUserName(String userId) async {
    print('Database getUserName: try');
    try {
      DocumentSnapshot documentSnapshot =
          await db.collection("users").doc(userId).get();
      return UserModel.fromDocumentSnapshot(documentSnapshot: documentSnapshot)
          .name;
    } catch (e) {
      print('Database getUserName: catch $e');
      rethrow;
    }
  }
}


