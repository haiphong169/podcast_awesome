import 'dart:convert';
import 'package:podcast_awesome/api_authentication.dart';
import 'package:podcast_awesome/widgets/podcasts/horizontal_podcast_item.dart';
import 'package:http/http.dart' as http;
import 'package:podcast_awesome/widgets/podcasts/podcast.dart';

Future<List<HorizontalListPodcastItem>> fetchTrendingPodcastsWithCategories(
    String category) async {
  List<HorizontalListPodcastItem> list = [];
  final response = await http.get(
      Uri.parse(
          'https://api.podcastindex.org/api/1.0/podcasts/trending?pretty&max=100&cat=$category'),
      headers: generateHeader());
  if (response.statusCode == 200) {
    Map<String, dynamic> res = json.decode(response.body);
    List<dynamic> feeds = res['feeds'] as List<dynamic>;
    for (var element in feeds) {
      if (!element['image'].contains('http') ||
          element['image'] ==
              'https://storage.warroom.org/images/AVN_YT_Banner_Pandemic_Live_-_smaller.png') {
        continue;
      }
      list.add(HorizontalListPodcastItem(podcast: Podcast.fromJson(element)));
    }
    return list;
  } else {
    throw Exception('Something went wrong. Please try again.');
  }
}

Future<List<HorizontalListPodcastItem>> fetchTrendingPodcasts() async {
  List<HorizontalListPodcastItem> list = [];

  final response = await http.get(
      Uri.parse(
          'https://api.podcastindex.org/api/1.0/podcasts/trending?pretty&max=100'),
      headers: generateHeader());
  if (response.statusCode == 200) {
    Map<String, dynamic> res = json.decode(response.body);
    List<dynamic> feeds = res['feeds'] as List<dynamic>;
    for (var element in feeds) {
      if (!element['image'].contains('http')) {
        continue;
      }
      list.add(HorizontalListPodcastItem(podcast: Podcast.fromJson(element)));
    }
    return list;
  } else {
    throw Exception('Failed to load results.');
  }
}
