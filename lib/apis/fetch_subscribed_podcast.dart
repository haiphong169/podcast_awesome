import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:podcast_awesome/api_authentication.dart';
import 'package:podcast_awesome/apis/database_queries.dart';
import 'package:podcast_awesome/widgets/podcasts/library_podcast.dart';
import 'package:podcast_awesome/widgets/podcasts/podcast.dart';

Future<List<LibraryPodcast>> fetchSubscribedPodcasts() async {
  List<LibraryPodcast> resList = [];
  var list = await getSubscriptionList();
  for (int id in list) {
    final response = await http.get(
        Uri.parse(
            'https://api.podcastindex.org/api/1.0/podcasts/byfeedid?id=$id&pretty'),
        headers: generateHeader());
    if (response.statusCode == 200) {
      Map<String, dynamic> res = json.decode(response.body)['feed'];
      resList.add(LibraryPodcast(podcast: Podcast.fromJson(res)));
    } else {
      throw Exception('Something went wrong. Please try again.');
    }
  }
  return resList;
}
