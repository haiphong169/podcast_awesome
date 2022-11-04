import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileOptionItem extends StatelessWidget {
  const ProfileOptionItem(
      {Key? key,
      required this.icon,
      required this.tapHandler,
      required this.title})
      : super(key: key);
  final IconData icon;
  final VoidCallback tapHandler;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: tapHandler,
      title: Text(title),
      leading: Icon(icon),
      trailing: const FaIcon(FontAwesomeIcons.angleRight),
    );
  }
}
