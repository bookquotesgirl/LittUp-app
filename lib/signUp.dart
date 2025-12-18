import 'package:flutter/material.dart';
import 'login.dart';

class SignupPage extends StatefulWidget{
  const SignupPage({super.key});

@override
  State<SignupPage> createState() =>_SignupPageState();

  
}

class _SignupPageState extends State<SignupPage>{
 final _formKey=GlobalKey<FormState>();
 final TextEditingController _emailController=TextEditingController();
 final TextEditingController _passwordController=TextEditingController();
 final TextEditingController _confirmPasswordController=TextEditingController();
 final TextEditingController _firstNameController=TextEditingController();
 final TextEditingController _lastNameController=TextEditingController();


void _register(){
  if(_formKey.currentState!.validate()){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginPage()));

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
                const Text('Sign Up', style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(labelText: 'First Name',border: OutlineInputBorder()),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if(value==null||value.isEmpty){
                      return 'Enter first name';}
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(labelText: 'Last Name',border: OutlineInputBorder()),
                  keyboardType: TextInputType.name,
                
                ),
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
                  keyboardType: TextInputType.visiblePassword,
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

                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(labelText: 'Re-enter password',border: OutlineInputBorder()),
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if(value==null||value.isEmpty){
                      return 'Enter pasword';}
                    if(value!=_passwordController.text){
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,//what does this do
                  height: 50,
                  child: ElevatedButton(onPressed: _register, child: const Text('Register')),
                ),
                const SizedBox(height: 10),
                TextButton( child: const Text("Already have an account? Login",
                style:TextStyle(color: Colors.blue,fontSize: 16)), onPressed:(){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginPage()));
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
