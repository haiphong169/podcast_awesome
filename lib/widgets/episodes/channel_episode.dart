import 'package:flutter/material.dart';
import 'package:podcast_awesome/player_manager.dart';
import 'package:podcast_awesome/screens/episode_player.dart';

import '../../apis/download_file.dart';
import 'episode.dart';

class ChannelEpisode extends StatelessWidget {
  ChannelEpisode({Key? key, required this.episode}) : super(key: key);

  final Episode episode;
  final _playerManager = PlayerManager();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Divider(
        indent: 20,
        endIndent: 20,
      ),
      InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EpisodePlayer(episode: episode))),
        child: Container(
          margin: const EdgeInsets.all(10),
          child: ListTile(
            leading: SizedBox(
              height: 70,
              width: 70,
              child: Image.network(episode.image, fit: BoxFit.fill),
            ),
            title: Text(episode.title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            subtitle: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _playerManager.addSong(episode);
                  },
                  child: const Text('Add to playlist'),
                ),
                ElevatedButton(
                    onPressed: () {
                      download(episode.mp3Url);
                    },
                    child: const Text('Download'))
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
