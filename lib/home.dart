import 'package:flutter/material.dart';

import './widgets/appBar.dart';
import 'storyPage.dart';
class Story {
  final String title;
  final String author;
  final String genre;
  final String image;

  int likes;
  int views;
  List<String> comments; 

  Story({
    required this.title,
    required this.author,
    required this.genre,
    required this.image,
    this.likes = 0,
    this.views = 0,
    List<String>? comments,
  }) : comments = comments ?? [];
}


class HomePage extends StatefulWidget{
  const HomePage({super.key});

@override
  State<HomePage> createState() =>_HomePageState();
}

class _HomePageState extends State<HomePage>{
  String dropdownvalue='All Catagories';
 final TextEditingController _searchController=TextEditingController();

  final List<Story> allStories=[
    Story(title: 'Finding Light', author: 'John Doe', genre: 'Romance', image: 'images/download.jpeg'),
    Story(title: 'Campus Days', author: 'Sara Lee', genre: 'Student Life', image: 'images/download.jpeg'),
  ];
   List<Story> filteredStories=[];

  @override
  void initState(){
    super.initState();
    filteredStories=List.from(allStories);
  }
  void _applyFilters(){
    final query=_searchController.text.toLowerCase();
    setState(() {
      filteredStories=allStories.where((story){
        final matchesSearch=
         story.title.toLowerCase().contains(query)||story.author.toLowerCase().contains(query)||story.genre.toLowerCase().contains(query);
         final matchesCategory=
         dropdownvalue=='All Catagories'||story.genre==dropdownvalue;

         return matchesSearch && matchesCategory;
      }).toList();
    });
  }
  var items=[
    'All Catagories',
    'Romance',
    'Student Life',
    'Most Recent',
  ];
  @override
Widget build(BuildContext context){
      return Scaffold(
        backgroundColor: Colors.white,
        
      appBar: const LittAppBar(),

      body:Padding(padding: 
      const EdgeInsets.all(60),
      child: 
       Column(
        children: [
          Align(
            alignment: AlignmentGeometry.topLeft,
          child: Text('Discover Stories', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

          ),
          SizedBox(
            width: double.infinity,
            height: 80,
            
          child: Row(
            children: [
              Expanded(child: 
              SearchBar(
                controller: _searchController,
                onChanged:(_)=> _applyFilters(),
                constraints: BoxConstraints(
                  minHeight: 40,
                  maxHeight: 80,
                ),
                side: WidgetStateProperty.all<BorderSide>(
    const BorderSide(
      color: Colors.black26, 
      width: 1.0, 
    ),
  ),
backgroundColor: const WidgetStatePropertyAll<Color>(Colors.white), // Set the background color
  surfaceTintColor: const WidgetStatePropertyAll<Color>(Colors.transparent),   //to prevent overlay
  elevation: WidgetStateProperty.all(0),         
  leading: Icon(Icons.search),
            hintText:  'Search by title, author or genre',
            
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )
            ),
            
          ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                height: 40,
  width: 220,
  child: 
              InputDecorator(
                decoration: const InputDecoration(border: OutlineInputBorder(
                
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),),
                
                child: DropdownButtonHideUnderline(
                  
                  child: 
              DropdownButton(
                elevation: 0,
                value: dropdownvalue,
                items:
                 items.map((String items){
                  return DropdownMenuItem(

                    value: items,
                    child: Text(items));
                 }
                 ).toList(), 
                 onChanged:
                  (String? newValue){
                    setState(() {
                      dropdownvalue=newValue!;
                    });
                    _searchController.clear();
                    _applyFilters();
                  },
                ),
                ),),
              ),
            ],
          
          ),
          ),
         
          Expanded(
            child: filteredStories.isEmpty?
                   const Center(
                    child: Text(
                      'No stories found',
                      style:TextStyle(color: Colors.grey),
                    ),
                  )
            : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.0,
                ), 
                
                itemCount: filteredStories.length,
                
              itemBuilder: (context, index){
                final story=filteredStories[index];
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
      MaterialPageRoute(builder: (context) => Storypage(story: story)),
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
          child: Image.asset(
            story.image,
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

      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          '1 year ago',
          style: TextStyle(fontSize: 13),
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
            Text('${story.comments.length}', style: TextStyle(fontSize: 12)),
            SizedBox(width: 16),
            Icon(Icons.remove_red_eye_outlined, size: 14, color: Colors.grey),
            SizedBox(width: 4),
            Text('$story.views', style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    ],
  ),
),

                );
              },  
            ),
          ),  
                    ],
                  ),
                  ),
                );

}
}