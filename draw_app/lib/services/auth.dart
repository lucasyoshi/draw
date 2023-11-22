
import 'package:draw_app/models/user.dart';
import 'package:draw_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class Auth {
  final auth.FirebaseAuth authInst = auth.FirebaseAuth.instance;

  void listen() {
    authInst.authStateChanges().listen((auth.User? user) {
      if (user == null) {
        print('Authorization listen; No User is signed in');
      } else {
        print('Authorization listen; user id: ${user.uid}');
        print('Authorization listen; user email: ${user.email}');
      }
    });
  }

  Future<bool> createUser(String name, String email, String password, bool signedInWithGoogle) async {
    try {
      auth.UserCredential credential =
          await authInst.createUserWithEmailAndPassword(
              email: email.trim(), password: password);
      credential.user!.updateDisplayName(name);
      UserModel userModel = UserModel(
        id: credential.user!.uid,
        name: name,
        email: credential.user!.email,
        signedInWithGoogle: signedInWithGoogle
      );
      await Database().createNewUser(userModel);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> createUserWithGoogle(String name, String email, String id, bool signedInWithGoogle) async {
  try {
    UserModel userModel = UserModel(
      id: id,
      name: name,
      email: email,
      signedInWithGoogle: signedInWithGoogle,
    );
    await Database().createNewUser(userModel);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

  Future<bool> logIn(String email, String password) async {
    try {
      auth.UserCredential credential = await authInst
          .signInWithEmailAndPassword(email: email.trim(), password: password);
      print('login user ${credential.user}');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> logOut() async {
    try {
      await authInst.signOut();
      print('logout user ${authInst.currentUser}');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
