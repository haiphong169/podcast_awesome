import 'package:flutter/material.dart';
import 'package:podcast_awesome/apis/search.dart';
import 'package:podcast_awesome/widgets/mybottomappbar.dart';
import 'package:podcast_awesome/widgets/podcasts/search_result_podcast.dart';
import 'package:podcast_awesome/widgets/searchbar.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  static const routeName = '/discover';

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController controller = TextEditingController();

  Future<List<SearchResultPodcast>>? searchResults;

  void getSearchResults(String value) {
    setState(() {
      searchResults = searchByTerm(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: Column(children: [
          const SizedBox(
            height: 70,
          ),
          SearchBar(
            controller: controller,
            onChanged: getSearchResults,
          ),
          const SizedBox(
            height: 30,
          ),
          FutureBuilder<List<SearchResultPodcast>>(
              future: searchResults,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                      child: ListView(
                    children: snapshot.data!,
                  ));
                }
                return const SizedBox();
              })
        ]),
      ),
      bottomNavigationBar: const MyBottomAppBar(),
    );
  }
}
