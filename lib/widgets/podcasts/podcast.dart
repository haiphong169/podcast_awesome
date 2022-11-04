class Podcast {
  const Podcast(
      {required this.id,
      required this.title,
      required this.description,
      required this.author,
      required this.image,
      required this.categories});
  final int id;
  final String title;
  final String description;
  final String author;
  final String image;
  final Map<String, dynamic> categories;

  factory Podcast.fromJson(Map<String, dynamic> json) {
    return Podcast(
        id: json['id'],
        title: json['title'].toString(),
        description: json['description'].toString(),
        author: json['author'].toString(),
        image: json['image'].toString(),
        categories: json['categories']);
  }

  @override
  String toString() {
    // TODO: implement toString
    return image;
  }
}
