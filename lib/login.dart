import 'package:flutter/material.dart';
import 'package:littup/home.dart';
import 'package:littup/signUp.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

@override
  State<LoginPage> createState() =>_LoginPageState();

}

class _LoginPageState extends State<LoginPage>{
 
  @override
Widget build(BuildContext context){
      return Scaffold(
      backgroundColor: const Color.fromARGB(255, 199, 228, 255),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 25,
              child: Icon(Icons.edit, color: Colors.white, size: 32),
              ),
                const SizedBox(height: 20),

              Text("LittUp", style: TextStyle(fontSize: 22)),
                const SizedBox(height: 15),
              Text("Share your stories, inspire others", style: TextStyle(fontSize: 18,color: Colors.grey)),
                const SizedBox(height: 25),
              SizedBox(
                width: 380,
                child:
                 Card(
                  
               color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
              
                children: <Widget>[
                const SizedBox(height: 20),
                  ListTile(
                    title: Text("Welcome back",style: TextStyle(fontWeight: FontWeight.w600),),
                    subtitle: const Text("Log in to your account to continue", style: TextStyle(fontSize: 16),),
                  ),
                const SizedBox(height: 20),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 15),
                  child: 
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      floatingLabelBehavior: FloatingLabelBehavior.always, 
                      hintText: 'Enter valid email',
                    ),
                  )
                  ),

                  Padding(padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
                   child: 
                   TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      floatingLabelBehavior: FloatingLabelBehavior.always, 
                      hintText: 'Enter your password',
                    ),
                  ),
                  ),
                  SizedBox(
                    height: 65,
                    width: 360,
                    child: Padding(padding: const EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ), onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomePage()));
                    }, child: Text('Log in', style: TextStyle(color: Colors.white, fontSize: 20),)),
                    ),
                  ),
                const SizedBox(height: 20),
                TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignupPage()));
                }, child:
                 const Text('Dont have an account? Sign up', style: TextStyle(color: Colors.black),)
                 ),
                const SizedBox(height: 20),

                ],
                 

              ),

              ),
              ),
             
            ],
          ),
        )
      );
}
}