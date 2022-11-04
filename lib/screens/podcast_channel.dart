import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:podcast_awesome/apis/database_queries.dart';
import 'package:podcast_awesome/apis/fetch_episodes.dart';
import 'package:podcast_awesome/user_info.dart';
import 'package:podcast_awesome/widgets/episodes/channel_episode.dart';
import 'package:podcast_awesome/widgets/podcasts/podcast.dart';

class PodcastChannel extends StatefulWidget {
  const PodcastChannel({Key? key, required this.podcast}) : super(key: key);
  final Podcast podcast;

  @override
  State<PodcastChannel> createState() => _PodcastChannelState();
}

class _PodcastChannelState extends State<PodcastChannel> {
  late Future<List<ChannelEpisode>> episodes;
  late Future<bool> isSubscribed;
  final SubscribeState _subscribeState = SubscribeState();

  @override
  void initState() {
    episodes = fetchAllEpisodesFromAPodcast(widget.podcast.id);
    isSubscribed = getSubscriptionState(widget.podcast.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 35,
          ),
          Image.network(
            widget.podcast.image,
            height: 300,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.podcast.title,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.podcast.author,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(widget.podcast.description),
          ),
          const SizedBox(
            height: 10,
          ),
          FutureBuilder<bool>(
              future: isSubscribed,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _subscribeState.subscribeNotifier.value = snapshot.data!;
                  return ValueListenableBuilder<bool>(
                      valueListenable: _subscribeState.subscribeNotifier,
                      builder: (_, value, __) {
                        return value == true
                            ? ElevatedButton(
                                onPressed: () {
                                  unsubscribe(widget.podcast.id);
                                  _subscribeState.change();
                                },
                                child: const Text('Unsubscribe'))
                            : ElevatedButton(
                                onPressed: () {
                                  updateUserSubscription(widget.podcast.id);
                                  _subscribeState.change();
                                },
                                child: const Text('Subscribe'));
                      });
                }
                return const CircularProgressIndicator();
              }),
          FutureBuilder<List<ChannelEpisode>>(
              future: episodes,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                      height: 700,
                      child: ListView(
                        children: snapshot.data!,
                      ));
                }
                return const CircularProgressIndicator();
              })
        ]),
      ),
    );
  }
}

class SubscribeState {
  final subscribeNotifier = ValueNotifier<bool>(false);

  change() {
    subscribeNotifier.value = !subscribeNotifier.value;
  }
}
