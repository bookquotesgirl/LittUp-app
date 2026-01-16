import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './widgets/appBar.dart';
import 'models/story.dart';
import 'package:firebase_auth/firebase_auth.dart';




class Comment {
  final String username;
  final String text;
  final DateTime timestamp;

  Comment({
    required this.username,
    required this.text,
    required this.timestamp,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      username: json['username'] ?? 'Anonymous',
      text: json['text'] ?? '',
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}


class Storypage extends StatefulWidget {
  final int storyId;
  const Storypage({super.key, required this.storyId});

  @override
  State<Storypage> createState() => _StorypageState();
}

class _StorypageState extends State<Storypage> {
  Story? story;
  List<Comment> comments = [];
  bool isLoading = true;

  final TextEditingController _commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchStory();
  }

  Future<void> _fetchStory() async {

    try {
      final response = await http.get(
        Uri.parse('http://192.168.1.6/littup_api/get_story.php?story_id=${widget.storyId}'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          story = Story.fromJson(data);
          comments = (data['comments'] as List)
              .map((c) => Comment.fromJson(c))
              .toList();
          isLoading = false;
        });
      } else {
        debugPrint('Failed to fetch story');
      }
    } catch (e) {
      debugPrint('Error fetching story: $e');
    }
  }

 Future<void> _postComment(String text) async {
  final currentUser = FirebaseAuth.instance.currentUser;
  if (story == null || text.isEmpty || currentUser == null) return;

  try {
    final response = await http.post(
      Uri.parse('http://192.168.1.6/littup_api/add_comment.php'),
      body: {
        'story_id': story!.id.toString(),
        'user_uid': currentUser.uid,
        'text': text,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final newComment = Comment.fromJson(data);
      setState(() {
        comments.add(newComment);
        story!.commentsCount++;
        _commentController.clear();
      });
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 100,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      debugPrint('Failed to post comment, status: ${response.statusCode}, body: ${response.body}');
    }
  } catch (e) {
    debugPrint('Error posting comment: $e');
  }
}




 Future<void> _updateLikes() async {
  if (story == null) return;
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser == null) return;

  try {
    final response = await http.post(
      Uri.parse('http://192.168.1.6/littup_api/like_story.php'),
      headers: {"Content-type": "application/x-www-form-urlencoded"},
      body: {
        'story_id': story!.id.toString(),
        'user_uid': currentUser.uid,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        story!.likes = data['likes'];
        story!.likedByCurrentUser = data['liked_by_current_user'];
      });
    } else {
      debugPrint('Failed to toggle like, status: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Error toggling like: $e');
  }
}



  String _formatTimeAgo(DateTime timestamp) {
    final diff = DateTime.now().difference(timestamp);
    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const LittAppBar(),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back button
            Row(
              children: [
                IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back)),
                const SizedBox(width: 20),
                const Text('Back to home'),
              ],
            ),

            // Title & author
            Text(story!.title, style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey,
                  child: Text(
                    story!.author.isNotEmpty ? story!.author[0].toUpperCase() : 'A',
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                const SizedBox(width: 20),
                Text(story!.author.isNotEmpty ? story!.author : 'Anonymous',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),

            const SizedBox(height: 20),
            Text(story!.content, style: const TextStyle(fontSize: 16, height: 1.5)),

            const Divider(thickness: 0.5, color: Colors.black, height: 20),

            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _updateLikes,
                  style: ElevatedButton.styleFrom
                  (backgroundColor: story!.likedByCurrentUser ? Colors.red : Colors.black,),
                  icon: const Icon(Icons.favorite, color: Colors.white),
                  label: Text('${story!.likes}', style: const TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 40),
                Icon(Icons.messenger_outline_rounded, color: Colors.grey),
                const SizedBox(width: 10),
                Text('${story!.commentsCount} Comments'),
                const SizedBox(width: 40),
                Icon(Icons.remove_red_eye_outlined, color: Colors.grey),
                const SizedBox(width: 10),
                Text('${story!.views} Reads'),
              ],
            ),

            const Divider(thickness: 0.5, color: Colors.black, height: 20),

            // Add comment
            const Text('Add a Comment', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
           
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  hintText: 'Write a comment...'),
              keyboardType: TextInputType.multiline,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
  onPressed: () {
    final text = _commentController.text.trim();
    _postComment(text);
  },
  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
  child: const Text('Post comment', style: TextStyle(color: Colors.white)),
),


            const SizedBox(height: 20),
            // Comments list
            Column(
              children: comments.map((comment) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.grey,
                                child: Text(
                                  comment.username[0].toUpperCase(),
                                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(comment.username, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  Text(_formatTimeAgo(comment.timestamp), style: const TextStyle(fontSize: 12)),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(comment.text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
