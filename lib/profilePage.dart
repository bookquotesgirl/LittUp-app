import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './widgets/appBar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './models/story.dart';
import 'storyPage.dart';
import 'package:timeago/timeago.dart' as timeago;

class UserProfile{
   String name;
  final String email;
  String bio;
   int storyCount;
   int totalLikes;
   int totalViews;
  final DateTime memberSince;

  UserProfile({
    required this.name,
    required this.bio,
    required this.email,
    required this.storyCount,
    required this.totalLikes,
    required this.totalViews,
    required this.memberSince,

  });

  factory UserProfile.fromJson(Map<String,dynamic> json){
    return UserProfile(name: json['name'] ?? 'Anonymous', 
    email: json['email'] ?? '', 
    bio: json['bio'] ?? '',
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

  bool isEditing=false;

  late TextEditingController nameController;
  late TextEditingController bioController;


  UserProfile? userProfile;
  List<Story> userStories=[];
  bool isLoading=true;

@override
void initState(){
  super.initState();
  _loadUserProfile();
}
Future<void> _saveProfile() async {
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser == null) return;

  final res = await http.post(
    Uri.parse('http://192.168.1.6/littup_api/update_profile.php'),
    body: {
      'firebase_uid': currentUser.uid,
      'name': nameController.text.trim(),
      'bio': bioController.text.trim(),
    },
  );

  if (res.statusCode == 200) {
    setState(() {
      userProfile!.name = nameController.text.trim();
      userProfile!.bio = bioController.text.trim();
    });
  }
}
Widget _statItem(String value, String label) {
  return Column(
    children: [
      Text(value,
          style: const TextStyle(
              fontSize: 26, fontWeight: FontWeight.bold)),
      Text(label),
    ],
  );
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
        final profile=UserProfile.fromJson(data);
        setState(() => userProfile = UserProfile.fromJson(data));

        setState((){
          userProfile=profile;
          nameController=TextEditingController(text: profile.name);
          bioController=TextEditingController(text: profile.bio);

        });
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
void dispose() {
  nameController.dispose();
  bioController.dispose();
  super.dispose();
}

  


  @override
Widget build(BuildContext context){
  final screenWidth= MediaQuery.of( context).size.width;
 final bool isMobile=screenWidth < 600;

  final double horizontalPadding=isMobile ? 16.0 : 60.0;



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
      EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 15,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: const Color.fromARGB(255, 240, 238, 238),
                    child: Text(userProfile!.name.isNotEmpty
                     ? userProfile!.name[0].toUpperCase()
                     : 'A',
                    style: TextStyle( fontSize:25,fontWeight: FontWeight.bold),)
                    ),
                  
                ],
            ),
            SizedBox(width: 20,),
Expanded(

                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isEditing

                    ? SizedBox(
                      width: 250,
                      child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    )
                    : Text(userProfile!.name,
                    style: TextStyle( fontSize:18,fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8,),
                    isEditing
                    ? SizedBox(
                      width: 250,
                      child: TextField(
                        controller: bioController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    )
                    :Text(userProfile!.bio.isNotEmpty
                    ? userProfile!.bio
                    : 'No bio yet',
                    style: TextStyle( fontSize:16,color: Colors.black26)), 
                                      ],
                ),
              
            ),
            Spacer(),

Row(
              children: [
              ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white,),
              onPressed: () async{
                   if(isEditing){
                    await _saveProfile();
                   }
                   setState(()=> isEditing = !isEditing);
              },
              icon:  Icon(
                isEditing? Icons.check: Icons.edit_outlined, color: Colors.black),
              label:  Text( isEditing ? 'Save' : 'Edit Profile', style: TextStyle(color: Colors.black)),
            ),
              ],
            ),
                  ],
                ),
            const SizedBox(height: 20,),
                Padding(padding:
                EdgeInsets.symmetric(
                  horizontal: isMobile ? 20: 80,
                ),
                child: 
              Wrap(
                alignment: WrapAlignment.spaceAround,
                spacing: 40,
                runSpacing: 16,
                children: [
                  
                    _statItem('${userProfile!.storyCount}', 'Stories'),
    _statItem('${userProfile!.totalLikes}', 'Likes'),
    _statItem('${userProfile!.totalViews}', 'Total reads'),
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
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: isMobile ? 1: 3,
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
    childAspectRatio:isMobile ?1.1: 0.72, 
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
      Expanded(child: 
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
      ),
      Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Text(
                story.title,
                style:  TextStyle(
                  fontSize: isMobile ? 14 : 16,
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
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
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
            Icon(Icons.favorite_border, size: isMobile ? 12: 14, color: Colors.grey),
            SizedBox(width: 4),
            Text('${story.likes}', style: TextStyle(fontSize: 12)),
            SizedBox(width: 16),
            Icon(Icons.messenger_outline_rounded, size: isMobile ? 12:14, color: Colors.grey),
            SizedBox(width: 4),
            Text('${story.commentsCount}', style: TextStyle(fontSize: 12)),
            SizedBox(width: 16),
            Icon(Icons.remove_red_eye_outlined, size: isMobile ? 12:14, color: Colors.grey),
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