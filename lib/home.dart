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
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          appBar: AppBar(
            automaticallyImplyLeading: false,
          backgroundColor: Colors.white,     
          title: Padding( padding: const EdgeInsets.only(left: 10,right: 10),
            
              child: const Text('LittUp',style: TextStyle(fontWeight: FontWeight.bold,fontFamily:" time new roman",color: Color.fromARGB(255, 10, 179, 205)))),
            actions:<Widget>[ 

              IconButton(onPressed: (){}, icon:Icon(Icons.person_2_outlined)),
              IconButton(onPressed: (){}, icon:Icon(Icons.exit_to_app_rounded)),
            
            ]
        ),
        body: Column(
          
        )
      
      );
}

}
