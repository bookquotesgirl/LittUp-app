import 'package:flutter/material.dart';
import './widgets/appBar.dart';
import 'storyPage.dart';
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
  width: 220,
  child: 
              InputDecorator(
                decoration: const InputDecoration(border: OutlineInputBorder(

                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),),
                
                child: DropdownButtonHideUnderline(
                  child: 
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
                ),),
              ),
            ],
          
          ),
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
                  child:
                  InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const Storypage()));
                    },
                    child:

                   Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(15),
                      ),
                    child: Image.asset('images/download.jpeg',height: 210,width: double.infinity,fit: BoxFit.cover,),
                      
                    ),
                    Padding(padding:
                    const EdgeInsets.all(20),
                    child:
                    Row(

                      children: [
  
                    
                    Text('Finding Light', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    Spacer(),
                    
                      Chip(label: 
                    Text('Inspiratinal', style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,),
                    ),
                    backgroundColor: Colors.grey.shade300,
                      ),
                    
                      ],
                    ),
                    ),
                    Padding(padding:
                    const EdgeInsets.all(20),
                    child:
                    Row(
                      children: [
                    
                    Text('by John Doe', style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    Spacer(),
                    Text('1 year ago', style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),

                      ],
                    ),
                    ),
                    Padding(padding:
                    const EdgeInsets.all(20),
                    child:
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
                    )
                    ],
                  ),
                  ),
                );

              },
              ),
          ),
            
                    
                  

                  ],
                ),
              )
      );
    
}

}