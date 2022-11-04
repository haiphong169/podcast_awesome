import 'package:flutter/material.dart';
import 'package:podcast_awesome/apis/auth.dart';
import 'package:podcast_awesome/widgets/auth_gate.dart';
import 'package:podcast_awesome/widgets/mybottomappbar.dart';
import 'package:podcast_awesome/widgets/profile_option_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ProfileOptionItem(
        icon: Icons.logout,
        title: 'Log Out',
        tapHandler: () {
          signOut();
          Navigator.pushNamed(context, AuthGate.routeName);
        },
      )),
      bottomNavigationBar: const MyBottomAppBar(),
    );
  }
}
