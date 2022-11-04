import 'package:flutter/material.dart';
import 'package:podcast_awesome/widgets/episodes/vertical_list_episode_item.dart';

class EpisodeVerticalList extends StatelessWidget {
  const EpisodeVerticalList({Key? key, required this.list}) : super(key: key);

  final List<VerticalListEpisodeItem> list;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      margin: const EdgeInsets.all(10),
      child: ListView(children: list),
    );
  }
}
