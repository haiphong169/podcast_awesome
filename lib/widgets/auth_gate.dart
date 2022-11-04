import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:podcast_awesome/screens/home.dart';
import 'package:podcast_awesome/screens/signin.dart';
import 'package:podcast_awesome/screens/signup.dart';
import 'package:podcast_awesome/user_info.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  static const routeName = '/authgate';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const AuthPage();
        }
        userId = snapshot.data!.uid;
        return const HomeScreen();
      },
    );
  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isSignIn = true;

  toggle() {
    setState(() {
      isSignIn = !isSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isSignIn ? SignInScreen(func: toggle) : SignUpScreen(func: toggle);
  }
}
