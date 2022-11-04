import 'package:flutter/material.dart';
import 'package:podcast_awesome/screens/podcast_channel.dart';
import 'package:podcast_awesome/widgets/podcasts/podcast.dart';

class HorizontalListPodcastItem extends StatelessWidget {
  const HorizontalListPodcastItem({Key? key, required this.podcast})
      : super(key: key);

  final Podcast podcast;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PodcastChannel(
                    podcast: podcast,
                  ))),
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 140,
        width: 140,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.network(podcast.image),
        ),
      ),
    );
  }
}
