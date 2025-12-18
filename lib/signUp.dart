import 'package:flutter/material.dart';
import 'login.dart';
class SignupPage extends StatefulWidget{
  const SignupPage({super.key});

@override
  State<SignupPage> createState() =>_SignUpPageState();

  
}

class _SignUpPageState extends State<SignupPage>{
  Widget? get child => null;

  @override
Widget build(BuildContext context){
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
           children: [ 
             
            const Text(
              "Login to facebook",
            style:TextStyle(
color: Color.fromARGB(255, 69, 111, 177),
                fontSize: 22,
                fontWeight: FontWeight.bold,
            ) 
            ),
        
            
            
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text(
              "Enter username",
              style: TextStyle(color: Colors.grey),
            ),
          
          ),
          
        
            
          
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text(
              "Enter password",
              style: TextStyle(color: Colors.grey),
            ),
          
          ),
           
         
ElevatedButton(
  onPressed: () {},
  child: const Text("Login "),
),

     
          
TextButton(
  onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginPage()));

  },
  child: const Text("Already have an account? Login "),
)

     
            
          ]),//don't clear
        ),
        );
    
}
}
