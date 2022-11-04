import 'package:flutter/material.dart';
import 'package:podcast_awesome/screens/podcast_channel.dart';
import 'package:podcast_awesome/widgets/podcasts/podcast.dart';

class SearchResultPodcast extends StatelessWidget {
  const SearchResultPodcast({Key? key, required this.podcast})
      : super(key: key);

  final Podcast podcast;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PodcastChannel(podcast: podcast))),
      child: ListTile(
        leading: Container(
            padding: const EdgeInsets.all(10),
            height: 150,
            child: ClipRRect(child: Image.network(podcast.image))),
        title: Text(podcast.title),
      ),
    );
  }
}
