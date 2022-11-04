import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:podcast_awesome/screens/discover.dart';
import 'package:podcast_awesome/screens/home.dart';
import 'package:podcast_awesome/screens/library.dart';
import 'package:podcast_awesome/screens/profile.dart';

class MyBottomAppBar extends StatelessWidget {
  const MyBottomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: () {
                if (ModalRoute.of(context)?.settings.name !=
                    HomeScreen.routeName) {
                  Navigator.pushNamed(context, HomeScreen.routeName);
                }
              },
              icon: const Icon(Icons.house)),
          IconButton(
              onPressed: () {
                if (ModalRoute.of(context)?.settings.name !=
                    DiscoverScreen.routeName) {
                  Navigator.pushNamed(context, DiscoverScreen.routeName);
                }
              },
              icon: const FaIcon(FontAwesomeIcons.compass)),
          IconButton(
              onPressed: () {
                if (ModalRoute.of(context)?.settings.name !=
                    LibraryScreen.routeName) {
                  Navigator.pushNamed(context, LibraryScreen.routeName);
                }
              },
              icon: const Icon(Icons.notes)),
          IconButton(
              onPressed: () {
                if (ModalRoute.of(context)?.settings.name !=
                    ProfileScreen.routeName) {
                  Navigator.pushNamed(context, ProfileScreen.routeName);
                }
              },
              icon: const Icon(Icons.person)),
        ],
      ),
    ));
  }
}
