import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget{
  const HomePage({super.key});

@override
  State<HomePage> createState() =>_HomePageState();
}

class _HomePageState extends State<HomePage>{
  @override
Widget build(BuildContext context){
      return Scaffold(
        
      appBar: AppBar(
        leading: CircleAvatar(
        backgroundColor: Colors.blue,
        child: Icon(Icons.edit, color: Colors.white,
        )
      ),
      actions:<Widget> [
        ElevatedButton.icon(style: ElevatedButton.styleFrom(backgroundColor: Colors.black,), onPressed: (){}, icon: const Icon(Icons.home_outlined,color: Colors.white,),label: const Text('Home',style: TextStyle(color: Colors.white),), ),
        const SizedBox(width: 10,),
        ElevatedButton.icon(style: ElevatedButton.styleFrom(backgroundColor: Colors.black), onPressed: (){}, icon: const Icon(CupertinoIcons.pen,color: Colors.white,),label: const Text('Write',style: TextStyle(color: Colors.white),), ),
        const SizedBox(width: 10,),
        ElevatedButton.icon(style: ElevatedButton.styleFrom(backgroundColor: Colors.black), onPressed: (){}, icon: const Icon(Icons.person_2_outlined,color: Colors.white,),label: const Text('Profile',style: TextStyle(color: Colors.white),), ),
        const SizedBox(width: 10,),
        ElevatedButton.icon(style: ElevatedButton.styleFrom(backgroundColor: Colors.black), onPressed: (){}, icon: const Icon(Icons.person_2_outlined,color: Colors.white,),label: const Text('Profile',style: TextStyle(color: Colors.white),), ),


      ],
      ),
      );
}

}
