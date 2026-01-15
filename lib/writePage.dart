import 'dart:io';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import './widgets/appBar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class Writepage extends StatefulWidget {
  const Writepage({super.key});

  @override
  State<Writepage> createState() => _WritepageState();
}

class _WritepageState extends State<Writepage> {
  File? coverImage;
  Uint8List? coverImageBytes;
  bool isPublishing=false;

  final _formKey = GlobalKey<FormState>();
  final  titleController = TextEditingController();
  final  contentController = TextEditingController();

  final user=FirebaseAuth.instance.currentUser;

  int wordCount=0;
  String category = 'Romance';

Future<void> pickCoverImage() async {
  final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (picked != null) {
    if (kIsWeb) {
      coverImageBytes = await picked.readAsBytes();
    } else {
      coverImage = File(picked.path);
    }
    setState(() {});
  }
}

      void updateWordCount(String text) {
  setState(() {
    wordCount = text.trim().isEmpty
        ? 0
        : text.trim().split(RegExp(r'\s+')).length;
  });
}

  Future<void> publishStory() async {
    if(user==null){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must be logged in')),
      );
      return;
    }
    if (!_formKey.currentState!.validate()) return;
    setState(()=>isPublishing=true
    );
    final uri= Uri.parse('http://192.168.1.6/littup_api/add_story.php');
    final request= http.MultipartRequest('POST', uri);

    request.fields['firebase_uid']=user!.uid;
    final String authorName = user?.displayName?.trim().isNotEmpty == true
       ? user!.displayName!
       : (user?.email?.split('@').first ?? 'Anonymous');

request.fields['author_name'] = authorName;
    request.fields['title']=titleController.text.trim();
    request.fields['content']=contentController.text.trim();
    request.fields['category']=category;

    if (kIsWeb && coverImageBytes != null) {
      request.files.add(
       http.MultipartFile.fromBytes(
        'cover',
        coverImageBytes! , 
        filename: 'cover_${DateTime.now().millisecondsSinceEpoch}.jpg',
        ),
        
      );
    }else if(!kIsWeb && coverImage!=null){
      request.files.add(
      await http.MultipartFile.fromPath(
        'cover',
        coverImage!.path,
         ),
         
      );
    }

   final response=await request.send();

   if(response.statusCode==200){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Story published')),
    );
    
    titleController.clear();
    contentController.clear();
    setState(() {
      coverImage=null;
      wordCount=0;
    });
   }else{
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Publish failed')),
    );
   }
      setState(()=>isPublishing=false);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: const LittAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 160, right: 160, top: 60, bottom: 60),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black, width: 1.0),
            ),

            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Write your story',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Share your creativity with the world',
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color.fromARGB(255, 129, 129, 129),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Title',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Give your story a title',
                      ),
                      validator: (v) =>
                        v == null || v.isEmpty ? 'Title required':null,
                        ),
                        
                    SizedBox(height: 20),

                    Text(
                      'Category',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    DropdownButtonFormField(
                value: category,
                items: const [
                  DropdownMenuItem(value: 'Romance', child: Text('Romance')),
                  DropdownMenuItem(
                      value: 'Student Life', child: Text('Student Life')),
                ],
                onChanged: (v) => setState(() => category = v!),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Category',
                ),
              ),
                    SizedBox(height: 20),

                    Text(
                      'Cover Image',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                        child: coverImageBytes != null
                        ? Image.memory(coverImageBytes!,fit: BoxFit.cover)
                        : coverImage !=null
                          ? Image.file(coverImage!,fit: BoxFit.cover)
                          :const Center(
                                child: Icon(
                                  Icons.add_a_photo,
                                  size: 40,
                                  color: Colors.grey,
                                ),
                              )
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          'Content',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '$wordCount words',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 300,
                      child: TextFormField(
                        controller: contentController,
                        onChanged: updateWordCount,
                        maxLines: null,
                        expands: true,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Start writing your story here',
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed:isPublishing?null:publishStory,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          child: isPublishing
                          ? CircularProgressIndicator(color: Colors.white,)
                          :Text('Publish'),
                         
                        ),
                        Spacer(),

                        ElevatedButton(
                          onPressed: (){},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),

                          child: Text(
                            'Save draft',
                            style: TextStyle(color: Colors.white),
                          ),
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
