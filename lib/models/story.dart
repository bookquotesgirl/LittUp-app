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
  bool likedByCurrentUser;

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
    this.likedByCurrentUser=false,
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
    likedByCurrentUser: (){ 
      final val= json['liked_by_current_user'];
      if(val==null) return false;
      if (val is bool) return val;
      if (val is int) return val==1;
      if (val is String) return val=='1' || val.toLowerCase()=='true';

      return false;
    }(),

  );
 
}

}
