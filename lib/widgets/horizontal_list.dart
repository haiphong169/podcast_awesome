import 'package:flutter/material.dart';
import 'package:podcast_awesome/widgets/podcasts/horizontal_podcast_item.dart';

class PodcastHorizontalList extends StatefulWidget {
  const PodcastHorizontalList(
      {Key? key, required this.title, required this.list})
      : super(key: key);
  final String title;
  final List<HorizontalListPodcastItem> list;

  @override
  State<PodcastHorizontalList> createState() => _PodcastHorizontalListState();
}

class _PodcastHorizontalListState extends State<PodcastHorizontalList> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        widget.list.length > 10 && !isExpanded
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  InkWell(
                    onTap: () => setState(() {
                      isExpanded = true;
                    }),
                    child: const Text(
                      'See all',
                      style: TextStyle(
                          color: Colors.pink,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            : Text(
                widget.title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 180,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: isExpanded ? widget.list : widget.list.sublist(0, 10),
          ),
        )
      ]),
    );
  }
}
