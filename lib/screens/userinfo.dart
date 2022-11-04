import 'package:flutter/material.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  static const routeName = '/userinfo';

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          const CircleAvatar(
            backgroundColor: Colors.black,
          ),
          const SizedBox(
            height: 50,
          ),
          InfoTextField(controller: _nameController, label: 'Full Name')
        ],
      ),
    );
  }
}

class InfoTextField extends StatelessWidget {
  const InfoTextField(
      {Key? key, required this.controller, required this.label, this.icon})
      : super(key: key);
  final TextEditingController controller;
  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          label: Text(label),
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 0, style: BorderStyle.none),
            borderRadius: BorderRadius.circular(20),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
        ),
      ),
    );
  }
}
