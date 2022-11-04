import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key, required this.controller, required this.onChanged})
      : super(key: key);

  final TextEditingController controller;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: TextField(
        onChanged: (value) => onChanged(value),
        controller: controller,
        decoration: InputDecoration(
          fillColor: Colors.grey[300],
          filled: true,
          hintText: 'Enter something...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 0, style: BorderStyle.none),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
