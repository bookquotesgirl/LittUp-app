import 'package:flutter/material.dart';
import './widgets/appBar.dart';
class Profilepage extends StatefulWidget{
  const Profilepage({super.key});

@override
  State<Profilepage> createState() =>_ProfilepageState();
}

class _ProfilepageState extends State<Profilepage>{
 
  @override
Widget build(BuildContext context){
      return Scaffold(
        backgroundColor: Colors.white,
        
      appBar: const LittAppBar(),
      body: Padding(padding: 
      EdgeInsets.only(
        top: 15,
        bottom: 15,
        left: 160,
        right:160,
      ),
      child: 
      Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: const Color.fromARGB(255, 240, 238, 238),
                    child: Text('SJ',style: TextStyle( fontSize:25,fontWeight: FontWeight.bold),)
                    ),
                  
                ],
            ),
Row(

              children: [
                Column(
                  children: [
                    Text('Sarah Johnson',style: TextStyle( fontSize:18,fontWeight: FontWeight.bold)),
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
              
            
            
              ],
            
            ),
          ),
        ],
      ),
      ),
      );
      
}
}