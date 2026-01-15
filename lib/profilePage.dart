import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './widgets/appBar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './models/story.dart';
import 'storyPage.dart';
import 'package:timeago/timeago.dart' as timeago;

class UserProfile{
  final String name;
  final String email;
   int storyCount;
   int totalLikes;
   int totalViews;
  final DateTime memberSince;

  UserProfile({
    required this.name,
    required this.email,
    required this.storyCount,
    required this.totalLikes,
    required this.totalViews,
    required this.memberSince,

  });

  factory UserProfile.fromJson(Map<String,dynamic> json){
    return UserProfile(name: json['name'] ?? 'Anonymous', 
    email: json['email'] ?? '', 
    storyCount: int.tryParse(json['story_count'].toString()) ?? 0, 
    totalLikes: int.tryParse(json['total_likes'].toString()) ?? 0, 
    totalViews: int.tryParse(json['total_views'].toString()) ?? 0, 
    memberSince: DateTime.parse(json['created_at']),
    );
  }

}

class Profilepage extends StatefulWidget{
  const Profilepage({super.key});

@override
  State<Profilepage> createState() =>_ProfilepageState();
}

class _ProfilepageState extends State<Profilepage>{
  UserProfile? userProfile;
  List<Story> userStories=[];
  bool isLoading=true;

@override
void initState(){
  super.initState();
  _loadUserProfile();
}
Future<void> _loadUserProfile() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    try {
      // Fetch user profile
      final userRes = await http.get(
          Uri.parse('http://192.168.1.6/littup_api/get_user.php?uid=${currentUser.uid}'));
      if (userRes.statusCode == 200) {
        final data = jsonDecode(userRes.body);
        setState(() => userProfile = UserProfile.fromJson(data));
      }

      // Fetch user stories
      final storiesRes = await http.get(
          Uri.parse('http://192.168.1.6/littup_api/get_user_stories.php?uid=${currentUser.uid}'));
      if (storiesRes.statusCode == 200) {
        final data = jsonDecode(storiesRes.body) as List;
        setState(() =>
            userStories = data.map((s) => Story.fromJson(s)).toList());
      }
    } catch (e) {
      debugPrint('Error loading profile: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
Widget build(BuildContext context){
  if(isLoading){
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),

    );
  }
      return Scaffold(
        backgroundColor: Colors.white,
        
      appBar: const LittAppBar(),
      body: SingleChildScrollView(
        child: 
      Padding(padding: 
      EdgeInsets.only(
        top: 15,
        bottom: 15,
        left: 160,
        right:160,
      ),
      child: 
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
          
          Container(
            
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: 
             Padding(padding: 
          EdgeInsets.all(20.0),
          
            child: Column(
              children: [
                Row(
                  children: [
Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: const Color.fromARGB(255, 240, 238, 238),
                    child: Text(userProfile!.name.isNotEmpty
                     ? userProfile!.name[0].toUpperCase()
                     : 'A',
                    style: TextStyle( fontSize:25,fontWeight: FontWeight.bold),)
                    ),
                  
                ],
            ),
            SizedBox(width: 20,),
Row(

              children: [
                
                Column(
                  children: [
                    Text(userProfile!.name,
                    style: TextStyle( fontSize:18,fontWeight: FontWeight.bold)),
                    Text('Passionate romance writer',style: TextStyle( fontSize:16,color: Colors.black26)), 
                                      ],
                ),
              ],
            ),
            Spacer(),

Row(
              children: [
              ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white,),
              onPressed: () {
                   
              },
              icon: const Icon(Icons.edit_outlined, color: Colors.black),
              label: const Text('Edit Profile', style: TextStyle(color: Colors.black)),
            ),
              ],
            ),
                  ],
                ),
            
                Padding(padding:
                const EdgeInsets.only(
                  left: 80,
                  right: 80,
                ),
                child: 
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text('${userProfile!.storyCount}',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold, ),),
                      Text('Stories'),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Text('${userProfile!.totalLikes}',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold, ),),
                      Text('Likes'),
                    ],
                  ),
                  Spacer(),

                  Column(
                    children: [
                      Text('${userProfile!.totalViews}',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold, ),),
                      Text('Total reads'),
                    ],
                  ),
                ],

              ),
                ),
              ],
            
            ),
          ),
          ),
          SizedBox(height: 30,),
          Text('Account info',style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(height: 15,),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child:
          SizedBox(
            width: double.infinity,
            
            child: 
              Padding(padding: 
              EdgeInsets.all(20),
              child:
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Email',style: TextStyle(fontWeight: FontWeight.bold),),
                Text(userProfile!.email,
                style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(height: 40,),
                 Text('Member since',style: TextStyle(fontWeight: FontWeight.bold),),
                Text(timeago.format(userProfile!.memberSince),
                  style: TextStyle(fontWeight: FontWeight.bold),),

              ],
            ),
              ),
            ),
           
          ),

          SizedBox(height: 30,),
          Text('My Stories',style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(height: 15,),

          GridView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  padding: const EdgeInsets.all(12),
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
    childAspectRatio: 0.72, 
  ),
  itemCount: userStories.length,
  itemBuilder: (context, index) {
    final story=userStories[index];
    return Card(
                color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child:
                   InkWell(
  borderRadius: BorderRadius.circular(15),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Storypage(storyId: story.id)),
    );
  },
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(15),
          ),
          child: Image.network(
            story.cover.isNotEmpty? story.cover:'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9SRRmhH4X5N2e4QalcoxVbzYsD44C-sQv-w&s',
            fit: BoxFit.cover,
          ),
        ),
      ),

      Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Text(
                story.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Chip(
              label: Text(story.genre),
              backgroundColor: Colors.grey.shade300,
            ),
          ],
        ),
      ),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          'by ${story.author}',
          style: const TextStyle(fontSize: 14),
        ),
      ),

      const SizedBox(height: 6),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          timeago.format(story.createdAt),
          style: const TextStyle(fontSize: 13),
        ),
      ),

      Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children:  [
            Icon(Icons.favorite_border, size: 14, color: Colors.grey),
            SizedBox(width: 4),
            Text('${story.likes}', style: TextStyle(fontSize: 12)),
            SizedBox(width: 16),
            Icon(Icons.messenger_outline_rounded, size: 14, color: Colors.grey),
            SizedBox(width: 4),
            Text('${story.commentsCount}', style: TextStyle(fontSize: 12)),
            SizedBox(width: 16),
            Icon(Icons.remove_red_eye_outlined, size: 14, color: Colors.grey),
            SizedBox(width: 4),
            Text('${story.views}', style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    ],
  ),
),

                );
  },
),


          

        ],
      ),
      ),
      ),
      );
      
}
}