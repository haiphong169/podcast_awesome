import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:podcast_awesome/api_authentication.dart';
import 'package:podcast_awesome/widgets/episodes/channel_episode.dart';
import 'package:podcast_awesome/widgets/episodes/episode.dart';
import 'package:podcast_awesome/widgets/episodes/vertical_list_episode_item.dart';

Future<List<VerticalListEpisodeItem>> fetchRecentEpisodes() async {
  List<VerticalListEpisodeItem> list = [];

  final response = await http.get(
      Uri.parse(
          'https://api.podcastindex.org/api/1.0/recent/episodes?max=20&pretty'),
      headers: generateHeader());
  if (response.statusCode == 200) {
    Map<String, dynamic> res = json.decode(response.body);
    List<dynamic> items = res['items'];
    for (var item in items) {
      list.add(VerticalListEpisodeItem(episode: Episode.fromJson(item)));
    }
    return list;
  } else {
    throw Exception('Failed to load results');
  }
}

Future<List<ChannelEpisode>> fetchAllEpisodesFromAPodcast(int podcastId) async {
  List<ChannelEpisode> list = [];
  final response = await http.get(
      Uri.parse(
          'https://api.podcastindex.org/api/1.0/episodes/byfeedid?id=$podcastId&pretty'),
      headers: generateHeader());
  if (response.statusCode == 200) {
    Map<String, dynamic> res = json.decode(response.body);
    List<dynamic> items = res['items'];
    for (var item in items) {
      list.add(ChannelEpisode(episode: Episode.fromJson(item)));
    }
    return list;
  } else {
    throw Exception('Failed to load results.');
  }
}
