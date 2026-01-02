import 'dart:io';
import 'package:flutter/material.dart';
import './widgets/appBar.dart';
import 'package:image_picker/image_picker.dart';
class Writepage extends StatefulWidget{
  const Writepage({super.key});

@override
  State<Writepage> createState() =>_WritepageState();
}

class _WritepageState extends State<Writepage>{
  File? coverImage;
  
 final _formKey=GlobalKey<FormState>();
 final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  String category = 'Romance';
 Future<void> pickCoverImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        coverImage = File(pickedFile.path);
      });
    }
  }
  @override
Widget build(BuildContext context){
      return Scaffold(
        backgroundColor: Colors.white,
        
      appBar: const LittAppBar(),
      body: SingleChildScrollView(
        child:
      Padding(
        padding: 
        EdgeInsets.only(
          left: 160,
          right: 160,
          top: 60,
          bottom: 60,
        ),
        child: 
        Container(
          
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              
              color: Colors.black,
              width: 1.0,
            )
          ),

          child: 
          Padding(
        padding: const EdgeInsets.all(16),
        child:
        Form(
        
         key: _formKey,

    
          child: 
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Write your story',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            Text('Share your creativity with the world',style: TextStyle(fontSize: 16,color: const Color.fromARGB(255, 129, 129, 129)),),
            SizedBox(height: 20,),
              Text('Title',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),), 

            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Give your story a title',
              ),
              validator: (value){
                if(value==null||value.trim().isEmpty){
                  return 'Title is required';
                }
                return null;
              },
            ),
            SizedBox(height: 20,),

              Text('Category',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),), 

           DropdownButtonFormField<String>(
                value: category,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'Romance', child: Text('Romance')),
                  DropdownMenuItem(value: 'Student Life', child: Text('Student Life')),
                  DropdownMenuItem(value: 'Inspiration', child: Text('Inspiration')),
                ],
                onChanged: (value) {
                  setState(() {
                    category = value!;
                  });
                },
              ),
            SizedBox(height: 20,),

              Text('Cover Image',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),), 
              GestureDetector(
                onTap: pickCoverImage,
                child: Container(
                  height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: coverImage != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  coverImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              )
            : const Center(
                child: Icon(Icons.add_a_photo, size: 40, color: Colors.grey),
              ),
                ),
              ),
            SizedBox(height: 20,),
Row(
  children: [
              Text('Content',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              Spacer(),
              Text('0 words',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),


  ],

),
              
       SizedBox(
          height: 300,
          child: TextFormField(
            controller: contentController,
            maxLines: null,
            expands: true,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Start writing your story here',
            ),
          ),
        ),
            SizedBox(height: 20,),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                 ElevatedButton(onPressed:(){ 
                    if (_formKey.currentState!.validate()) {
                        // publish logic
                      } 
},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
child: Text('Publish',style: TextStyle(color: Colors.white)),
),
Spacer(),

ElevatedButton(onPressed:(){ },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),

child: Text('Save draft',style: TextStyle(color: Colors.white)),
),
                ],
              ),
          ],
         ),
          
        ),
        ),
          ),
      ),
      ),
      );
      
}
}