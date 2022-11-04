class Episode {
  Episode({
    required this.mp3Url,
    required this.description,
    required this.image,
    required this.podcastTitle,
    required this.podcastId,
    required this.datePublished,
    required this.title,
  });
  final String title;
  final String mp3Url;
  final String description;
  final String image;
  final String podcastTitle;
  final int podcastId;
  final String datePublished;

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
        mp3Url: json['enclosureUrl'],
        description: json['description'],
        image: json['feedImage'],
        podcastTitle: json['feedTitle'],
        podcastId: json['feedId'],
        datePublished: json['datePublishedPretty'],
        title: json['title']);
  }

  @override
  String toString() {
    return 'TITLE $title \nMP3URL $mp3Url \nDESCRIPTION $description \nIMAGE$image \nPODCASTTITLE$podcastTitle \nDATE$datePublished';
  }
}
