import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget{
  const HomePage({super.key});

@override
  State<HomePage> createState() =>_HomePageState();
}

class _HomePageState extends State<HomePage>{
 
  String dropdownvalue='All Catagories';
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
      appBar: AppBar(
        title: Text('LittUp', style: TextStyle(fontSize: 18, fontWeight:FontWeight.bold),),
        toolbarHeight: 40,
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
      body: Column(
        children: [
          Text('Discover Stories', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          Row(
            children: [
              SearchBar(
            leading: Icon(Icons.search),
            hintText:  'Search by title, author or genre',
          ),
          DropdownButton(
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
              },
            ),
            ],
            
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.0,
                ), 
                itemCount: 6,
              itemBuilder: (context, index){
                return Card(
                color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(15),
                      ),
                    child: Image.asset('images/download.jpeg',height: 210,width: double.infinity,fit: BoxFit.cover,),
                      
                    ),
                    Row(
                      children: [
                        const Padding(padding: EdgeInsets.all(6),
                    
                    child: Text('Finding Light', style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    ),
                    Text('Inspiratinal', style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,backgroundColor: const Color.fromARGB(193, 158, 158, 158)),),

                      ],
                    ),
                    Row(
                      children: [
                        const Padding(padding: EdgeInsets.all(6),
                    
                    child: Text('by John Doe', style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    ),
                    Text('1 year ago', style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),

                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.favorite_border,color: Colors.grey,size: 14,),
                        Text('67',style: TextStyle(color: Colors.grey,fontSize: 14),),
                        SizedBox(width: 20),
                         Icon(Icons.messenger_outline_rounded,color: Colors.grey,size: 14),
                        Text('50',style: TextStyle(color: Colors.grey,fontSize: 14),),
                        SizedBox(width: 20),
                         Icon(Icons.remove_red_eye_outlined,color: Colors.grey,size: 14),
                        Text('670',style: TextStyle(color: Colors.grey,fontSize: 14),),
                      ],
                    ),
                    ],
                  ),
                );
              },
              ),
          ),
                
                    
                  

                  ],
                ),
              );
    
}

}
