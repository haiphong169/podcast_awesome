import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:podcast_awesome/firebase_options.dart';
import 'package:podcast_awesome/screens/discover.dart';
import 'package:podcast_awesome/screens/home.dart';
import 'package:podcast_awesome/screens/intro.dart';
import 'package:podcast_awesome/screens/userinfo.dart';
import 'package:podcast_awesome/widgets/auth_gate.dart';

import 'screens/library.dart';
import 'screens/profile.dart';

Future<void> main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(const MyApp());
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Podcast Awesome',
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        DiscoverScreen.routeName: (context) => const DiscoverScreen(),
        LibraryScreen.routeName: (context) => const LibraryScreen(),
        ProfileScreen.routeName: (context) => const ProfileScreen(),
        AuthGate.routeName: (context) => const AuthGate(),
        UserInfoScreen.routeName: (context) => const UserInfoScreen(),
      },
      home: const IntroScreen(),
    );
  }
}
