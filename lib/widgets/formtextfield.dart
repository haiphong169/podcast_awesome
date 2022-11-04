import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  const FormTextField(
      {Key? key,
      required this.controller,
      required this.label,
      required this.isPassword})
      : super(key: key);

  final TextEditingController controller;
  final String label;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 0, style: BorderStyle.none),
            borderRadius: BorderRadius.circular(20),
          ),
          filled: true,
          label: Text(label),
          prefixIcon:
              isPassword ? const Icon(Icons.lock) : const Icon(Icons.email),
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }
}
