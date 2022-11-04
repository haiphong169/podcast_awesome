import 'package:flutter/material.dart';
import 'package:podcast_awesome/apis/fetch_subscribed_podcast.dart';
import 'package:podcast_awesome/widgets/mybottomappbar.dart';
import 'package:podcast_awesome/widgets/podcasts/library_podcast.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  static const routeName = '/library';

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  late Future<List<LibraryPodcast>> subscribedPodcasts;

  @override
  void initState() {
    // TODO: implement initState
    subscribedPodcasts = fetchSubscribedPodcasts();
    print(subscribedPodcasts);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<LibraryPodcast>>(
        future: subscribedPodcasts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!,
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: const MyBottomAppBar(),
    );
  }
}
