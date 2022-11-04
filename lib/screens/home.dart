import 'package:flutter/material.dart';
import 'package:podcast_awesome/apis/fetch_episodes.dart';
import 'package:podcast_awesome/apis/fetch_trending_podcasts.dart';
import 'package:podcast_awesome/widgets/episodes/vertical_list_episode_item.dart';
import 'package:podcast_awesome/widgets/horizontal_list.dart';
import 'package:podcast_awesome/widgets/logo.dart';
import 'package:podcast_awesome/widgets/mybottomappbar.dart';
import 'package:podcast_awesome/widgets/podcasts/horizontal_podcast_item.dart';
import 'package:podcast_awesome/widgets/vertical_list_episode.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<HorizontalListPodcastItem>> history;
  late Future<List<HorizontalListPodcastItem>> politics;
  late Future<List<HorizontalListPodcastItem>> comedy;
  late Future<List<HorizontalListPodcastItem>> news;
  late Future<List<HorizontalListPodcastItem>> trending;
  late Future<List<HorizontalListPodcastItem>> health;
  late Future<List<HorizontalListPodcastItem>> business;
  late Future<List<HorizontalListPodcastItem>> investing;
  late Future<List<VerticalListEpisodeItem>> latestEpisodes;

  @override
  void initState() {
    super.initState();
    history = fetchTrendingPodcastsWithCategories('History');
    politics = fetchTrendingPodcastsWithCategories('Politics');
    comedy = fetchTrendingPodcastsWithCategories('Comedy');
    news = fetchTrendingPodcastsWithCategories('News');
    health = fetchTrendingPodcastsWithCategories('Health');
    business = fetchTrendingPodcastsWithCategories('Business');
    investing = fetchTrendingPodcastsWithCategories('Investing');
    trending = fetchTrendingPodcasts();
    latestEpisodes = fetchRecentEpisodes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<List<List<HorizontalListPodcastItem>>>(
              future: Future.wait([
                history,
                politics,
                comedy,
                news,
                trending,
                health,
                business,
                investing
              ]),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      const Logo(),
                      const SizedBox(
                        height: 50,
                      ),
                      PodcastHorizontalList(
                          title: 'Trending', list: snapshot.data![4]),
                      PodcastHorizontalList(
                          title: 'History', list: snapshot.data![0]),
                      PodcastHorizontalList(
                          title: 'Politics', list: snapshot.data![1]),
                      PodcastHorizontalList(
                          title: 'Comedy', list: snapshot.data![2]),
                      PodcastHorizontalList(
                          title: 'News', list: snapshot.data![3]),
                      PodcastHorizontalList(
                          title: 'Health', list: snapshot.data![5]),
                      PodcastHorizontalList(
                          title: 'Business', list: snapshot.data![6]),
                      PodcastHorizontalList(
                          title: 'Investing', list: snapshot.data![7]),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
          FutureBuilder<List<VerticalListEpisodeItem>>(
              future: latestEpisodes,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      const Text(
                        'Latest Episodes',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      EpisodeVerticalList(list: snapshot.data!)
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              })
        ],
      )),
      bottomNavigationBar: const MyBottomAppBar(),
    );
  }
}
