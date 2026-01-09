import 'package:flutter/material.dart';
import './widgets/appBar.dart';
import 'home.dart';
class Storypage extends StatefulWidget{
    final Story story;
  const Storypage({super.key, required this.story});

@override
  State<Storypage> createState() =>_StorypageState();
}

class _StorypageState extends State<Storypage>{

 int views = 120;
int likes = 38;
List<String> comments = ['This is incredible'];
final TextEditingController _commentController = TextEditingController();
@override
void initState() {
  super.initState();
  views++; 
}

  @override
Widget build(BuildContext context){
  return Scaffold(
        backgroundColor: Colors.white,
      appBar: const LittAppBar(),
      body: SingleChildScrollView(
     padding: 
      EdgeInsets.only(
        top:20,
        bottom:20,
        left:120,
        right:120,
      ),
      child: 
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomePage()));

              }, icon: Icon(Icons.arrow_back)),
              SizedBox(width: 20,),
            Text('Back to home'),
            ],
          ),
          Title(color: Colors.black, child: 
          Text('Finding Light',style: TextStyle(fontSize: 35,color: Colors.black, fontWeight: FontWeight.bold),),
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey,
                child: Text('MC',style: TextStyle(fontSize: 20,color: Colors.black, fontWeight: FontWeight.bold),),
              ),
              SizedBox(width: 30,),
              Text('Mike Chen',style: TextStyle(fontSize: 20,color: Colors.black, fontWeight: FontWeight.bold),),
            ],
          ),
          Text(
  '''

Sometimes life knocks you down. You lose your job, a relationship ends, or you face a challenge that seems insurmountable. I know because I've been there.

Two years ago, I was at my lowest point. I had just graduated from college with no job prospects, mounting debt, and a deep sense of failure. Every morning felt like a battle just to get out of bed.

But here's what I learned: darkness makes you appreciate the light.

I started small. I made a list of three things I was grateful for each day. At first, it felt forced. "I'm grateful for my morning coffee." "I'm grateful for sunny weather." But slowly, I started to notice more – a friend's text message, a stranger's smile, the way my cat purrs when I pet her.

I volunteered at a local community center, helping kids with their homework. Seeing their faces light up when they understood a concept reminded me that I had value, that I could make a difference.

I took online courses, networked, and applied to jobs even when rejection seemed certain. And eventually, after countless "no's," I got a "yes."

Today, I'm not where I thought I'd be at 25, but I'm somewhere better. I'm stronger, more compassionate, and more grateful. The darkness taught me to find my own light, and now I try to share that light with others.

If you're going through tough times, know this: you are stronger than you think, and this too shall pass.
  ''',
),
 Divider(
  color: Colors.black, // Color of the line
  thickness: 0.5,        // Thickness of the line
  height: 20,          // Total height of the box, padding is computed from this
 
       // Empty space at the end (right) of the line
),
Padding(padding: 
EdgeInsets.only(
  top: 20,
),
child:
Row(
children: [
    ElevatedButton.icon(
  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
  onPressed: () {
    setState(() {
      likes++;
    });
  },
  icon: const Icon(Icons.favorite, color: Colors.white),
  label: Text('$likes', style: const TextStyle(color: Colors.white)),
),

            SizedBox(width:40),
            Icon(Icons.messenger_outline_rounded,color: Colors.grey,),
            SizedBox(width:10),
            Text('${comments.length} Comments'),

            SizedBox(width:40),
             Icon(Icons.remove_red_eye_outlined,color: Colors.grey,),
            SizedBox(width:10),
            Text('120 Reads'),
],
),
),
 Divider(
  color: Colors.black, // Color of the line
  thickness: 0.5,        // Thickness of the line
  height: 20,          // Total height of the box, padding is computed from this
 
       // Empty space at the end (right) of the line
),
Text('Comments (1)'),
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
  EdgeInsets.all(40),
  child:
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextField(
  controller: _commentController,
  decoration: InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    hintText: 'Share your thoughts...',
  ),
  keyboardType: TextInputType.multiline,
),

      SizedBox(height: 30,),
      ElevatedButton(
  onPressed: () {
    final text=_commentController.text.trim();
    if(text.isEmpty)
     return;

    setState(() {
      widget.story.comments.add(text);
      
      _commentController.clear();
    });
  },
  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
  child: const Text('Post comment', style: TextStyle(color: Colors.white)),
),
Column(
  children:widget.story.comments.map((comment){
    return Padding(padding: 
    const EdgeInsets.only(top:20),
    child: Text(comment),
    );
  }).toList(),
   
)
    ],
  ),
  ),
),
      SizedBox(height: 30,),
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
  EdgeInsets.all(40),
  child:
  Column(
  children: comments.map((comment) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey,
                    child: Text('ED'),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Emma Davis',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Just now'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                comment,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }).toList(),
),

  ),
),
        ],
      ),
      )
  
  );
      }

}