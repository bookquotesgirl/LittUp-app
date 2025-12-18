import 'package:flutter/material.dart';
import 'signUp.dart';
import 'home.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

@override
  State<LoginPage> createState() =>_LoginPageState();

  
}

class _LoginPageState extends State<LoginPage>{
 final _formKey=GlobalKey<FormState>();
 final TextEditingController _emailController=TextEditingController();
 final TextEditingController _passwordController=TextEditingController();

void _login(){
  if(_formKey.currentState!.validate()){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomePage()));

  }
}
  @override
Widget build(BuildContext context){
      return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Center(
          child: Padding(padding:const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
              
              children: [
                const Icon(Icons.person,size:100,color: Colors.blue),
                const SizedBox(height: 20),
                const Text('Login', style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email',border: OutlineInputBorder()),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if(value==null||value.isEmpty){
                      return 'Enter email';}
                    if(!RegExp(r'\S+@\S+\.\S+').hasMatch(value)){
                      return 'Enter valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password',border: OutlineInputBorder()),
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if(value==null||value.isEmpty){
                      return 'Enter pasword';}
                    if(value.length<6){
                      return 'Password too short';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,//what does this do
                  height: 50,
                  child: ElevatedButton(onPressed: _login, child: const Text('Login')),
                ),
                const SizedBox(height: 10),
                TextButton( child: const Text("Don't have an account? Signup",
                style:TextStyle(color: Colors.blue,fontSize: 16)), onPressed:(){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignupPage()));
                }
                )
              ],
            )
            )
          ),
        ),
        )
      );
}
}
