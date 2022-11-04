import 'package:flutter/material.dart';
import 'package:podcast_awesome/palette.dart';
import 'package:podcast_awesome/widgets/auth_gate.dart';
import 'package:podcast_awesome/widgets/button.dart';

import '../widgets/logo.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color1, color2, color3, color4])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 200,
            ),
            const Logo(),
            const SizedBox(
              // to do: fix back to 400
              height: 400,
            ),
            Button(
              fullWidth: true,
              tapHandler: () =>
                  Navigator.pushNamed(context, AuthGate.routeName),
              title: 'Let\'s get started!',
              useLightTheme: true,
            )
          ],
        ),
      ),
    );
  }
}
