class Story {
  final int id;
  final String title;
  final String content;
  final String author;
  final String genre;
  final String cover;
   int likes;
   int views;
   int commentsCount;
  final DateTime createdAt;

  Story({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.genre,
    required this.cover,
    required this.likes,
    required this.views,
    required this.commentsCount,
    required this.createdAt,
  });

 factory Story.fromJson(Map<String, dynamic> json) {
  return Story(
    id: int.parse(json['id'].toString()),
    title: json['title'] ?? '',
    author: json['author'] ?? 'Anonymous',
    content: json['content'] ?? '',
    genre: json['genre'] ?? 'Unknown',
    cover: json['cover'] ?? '',
    likes: int.parse(json['likes'].toString()),
    views: int.parse(json['views'].toString()),

    commentsCount: int.parse(json['commentsCount'].toString()),
    createdAt: DateTime.parse(json['createdAt']),
  );
}

}
