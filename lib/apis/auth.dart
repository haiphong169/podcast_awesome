// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:podcast_awesome/apis/database_queries.dart';
import 'package:podcast_awesome/user_info.dart';

final auth = FirebaseAuth.instance;

signUp(email, password, context) async {
  // auth.authStateChanges().listen((User? user) {
  //   if (user != null) {
  //     Navigator.pushNamed(context, HomeScreen.routeName);
  //   } else {
  //     Navigator.popUntil(context, ModalRoute.withName('/'));
  //   }
  // });
  try {
    final credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    userId = credential.user!.uid;
    addNewUser();
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      return 'The account already exists for that email.';
    } else if (e.code == 'unknown') {
      return 'Please enter an email and a password.';
    }
  }
}

signIn(email, password, context) async {
  try {
    final credential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    userId = credential.user!.uid;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      return 'Wrong password.';
    } else if (e.code == 'unknown') {
      return 'Please enter an email and password.';
    }
  }
}

signOut() async {
  try {
    await auth.signOut();
  } catch (e) {
    print(e);
  }
}
