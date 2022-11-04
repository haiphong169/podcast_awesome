import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:podcast_awesome/api_authentication.dart';
import 'package:podcast_awesome/widgets/podcasts/podcast.dart';
import 'package:podcast_awesome/widgets/podcasts/search_result_podcast.dart';

Future<List<SearchResultPodcast>> searchByTerm(String searchTerm) async {
  List<SearchResultPodcast> list = [];
  final response = await http.get(
      Uri.parse(
          'https://api.podcastindex.org/api/1.0/search/byterm?pretty&q=$searchTerm'),
      headers: generateHeader());
  if (response.statusCode == 200) {
    Map<String, dynamic> res = json.decode(response.body);
    List<dynamic> feeds = res['feeds'];
    for (var feed in feeds) {
      list.add(SearchResultPodcast(podcast: Podcast.fromJson(feed)));
    }
    return list;
  } else {
    throw Exception('Failed to load results.');
  }
}
