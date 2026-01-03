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
                    child: Text('SJ',style: TextStyle( fontSize:25,fontWeight: FontWeight.bold),)
                    ),
                  
                ],
            ),
            SizedBox(width: 20,),
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
                      Text('2',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold, ),),
                      Text('Stories'),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Text('98',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold, ),),
                      Text('Likes'),
                    ],
                  ),
                  Spacer(),

                  Column(
                    children: [
                      Text('329',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold, ),),
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
                Text('Your email',style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(height: 40,),
                 Text('Member since',style: TextStyle(fontWeight: FontWeight.bold),),
                Text('Date',style: TextStyle(fontWeight: FontWeight.bold),),

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
    childAspectRatio: 0.72, // 👈 important
  ),
  itemCount: 2,
  itemBuilder: (context, index) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(15),
            ),
            child: Image.asset(
              'images/download.jpeg',
              height: 210,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Title + Chip
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Finding Light',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Chip(
                  label: Text(
                    'Inspirational',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Colors.grey.shade300,
                ),
              ],
            ),
          ),

          // Author + time
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  'by John Doe',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  '1 year ago',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // Stats
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: const [
                Icon(Icons.favorite_border, color: Colors.grey, size: 14),
                SizedBox(width: 4),
                Text('67', style: TextStyle(color: Colors.grey)),
                SizedBox(width: 16),
                Icon(Icons.messenger_outline_rounded,
                    color: Colors.grey, size: 14),
                SizedBox(width: 4),
                Text('50', style: TextStyle(color: Colors.grey)),
                SizedBox(width: 16),
                Icon(Icons.remove_red_eye_outlined,
                    color: Colors.grey, size: 14),
                SizedBox(width: 4),
                Text('670', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
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