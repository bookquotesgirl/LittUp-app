import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../writePage.dart';

class LittAppBar extends StatelessWidget implements PreferredSizeWidget{
  const LittAppBar({super.key});
   @override

  Size get preferredSize=>const Size.fromHeight(kToolbarHeight);

   @override
Widget build(BuildContext context){
  return AppBar(
      elevation: 0,
     backgroundColor: Colors.white,

  automaticallyImplyLeading: false,
  shape: const Border(
    bottom: BorderSide(color: Colors.grey, width: 0.5),
  ),
  title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: logo + title
          Row(
            children: const [
              CircleAvatar(
                radius: 16,
                backgroundColor: Color.fromARGB(255, 8, 74, 128),
                child: Icon(Icons.edit, color: Colors.white, size: 18),
              ),
              SizedBox(width: 8),
              Text(
                'LittUp',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          Row(
            children: [
             ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () {},
              icon: const Icon(Icons.home_outlined, color: Colors.white),
              label: const Text('Home', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(width: 10,),
              ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const Writepage()));

              },
              icon: const Icon(CupertinoIcons.pen, color: Colors.white),
              label: const Text('Write', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(width: 10,),

             ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () {},
              icon: const Icon(Icons.person_2_outlined, color: Colors.white),
              label:
                  const Text('Profile', style: TextStyle(color: Colors.white)),
            ),
            ],
          ),
        ],
      ),
    
  );
}
}