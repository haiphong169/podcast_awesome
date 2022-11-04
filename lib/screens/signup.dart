import 'package:flutter/material.dart';
import 'package:podcast_awesome/apis/auth.dart';
import 'package:podcast_awesome/palette.dart';
import 'package:podcast_awesome/widgets/button.dart';
import 'package:podcast_awesome/widgets/formtextfield.dart';
import 'package:podcast_awesome/widgets/logo.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key, required this.func}) : super(key: key);

  final VoidCallback func;

  static const routeName = '/signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? error = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 100,
          ),
          const Logo(),
          const SizedBox(
            height: 100,
          ),
          FormTextField(
              controller: _emailController, label: 'Email', isPassword: false),
          const SizedBox(
            height: 50,
          ),
          FormTextField(
              controller: _passwordController,
              label: 'Password',
              isPassword: true),
          const SizedBox(
            height: 50,
          ),
          error != ''
              ? Text(
                  error!,
                  style: const TextStyle(color: Colors.red),
                )
              : const SizedBox(),
          Button(
              tapHandler: () async {
                error = await signUp(
                    _emailController.text, _passwordController.text, context);
                error ??= '';
                setState(() {});
              },
              useLightTheme: false,
              title: 'Sign Up',
              fullWidth: true),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Already have an account? ',
                  style: TextStyle(color: Colors.black)),
              GestureDetector(
                onTap: () => widget.func(),
                child: const Text('Sign in',
                    style:
                        TextStyle(color: color1, fontWeight: FontWeight.bold)),
              )
            ],
          )
        ]),
      ),
    );
  }
}
