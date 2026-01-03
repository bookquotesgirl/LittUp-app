import 'package:flutter/material.dart';
import './widgets/appBar.dart';
import 'home.dart';
class Storypage extends StatefulWidget{
  const Storypage({super.key});

@override
  State<Storypage> createState() =>_StorypageState();
}

class _StorypageState extends State<Storypage>{
 
  @override
Widget build(BuildContext context){
  return Scaffold(
        backgroundColor: Colors.white,
      appBar: const LittAppBar(),
      body: Padding(padding: 
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
)

        ],
      ),
      )
  
  );
      }

}