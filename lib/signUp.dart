import 'package:flutter/material.dart';
import 'package:littup/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class HoverUnderlineTextButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const HoverUnderlineTextButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  State<HoverUnderlineTextButton> createState() =>
      _HoverUnderlineTextButtonState();
}

class _HoverUnderlineTextButtonState extends State<HoverUnderlineTextButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: TextButton(
        onPressed: widget.onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
        ).copyWith(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
          elevation: MaterialStateProperty.all(0),
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            color: Colors.black,
            decoration: _isHovered ? TextDecoration.underline : TextDecoration.none,
          ),
        ),
      ),
    );
  }
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  final _formKey=GlobalKey<FormState>();

  Future<void> signUpWithEmail() async {
    if(!_formKey.currentState!.validate())
    return;
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign-up successful')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Sign-up failed")),
      );
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) 
      return ; 

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

       await FirebaseAuth.instance.signInWithCredential(credential);
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Google sign-in successful')),
       );
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginPage()),
       );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Google sign-in failed')),
      );
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 199, 228, 255),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 25,
                child: Icon(Icons.edit, color: Colors.white, size: 32),
              ),
              const SizedBox(height: 20),
              const Text("LittUp", style: TextStyle(fontSize: 22)),
              const SizedBox(height: 15),
              const Text(
                "Share your stories, inspire others",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: 380,
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Form(
                      key: _formKey,
                      child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const ListTile(
                          title: Text(
                            "Create an account",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            "Join our community of writers and readers",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        const SizedBox(height: 20),
                       TextFormField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Name',
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              hintText: 'John Doe',
                            ),
                            validator: (value){
                              if(value==null||value.trim().isEmpty){
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15,),
                        
                        TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              hintText: 'Enter valid email',
                            ),
                            validator: (value){
                              if(value==null||value.trim().isEmpty){
                                return 'Please enter your email';
                              }
                              final emailRegex=RegExp(
                                r'^[^@]+@[^@]+\.[^@]+'
                           
                              );
                              if(!emailRegex.hasMatch(value)){
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),

                        
                        const SizedBox(height: 20),
                        TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              hintText: 'Enter your password',
                            ),
                            validator: (value){
                              if(value==null||value.trim().isEmpty){
                                return 'Please enter a password';
                              }
                              if(value.length<6){
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                        
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                            ),
                            onPressed: signUpWithEmail,
                            child: const Text(
                              'Sign up',
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              elevation: 0,
                            ),
                            onPressed: signInWithGoogle,
                            child:
                            const Text(
                              'Continue with Google',
                              style:TextStyle(fontSize: 16),
                            ),
                           ),
                         ),
                         const SizedBox(height: 15,),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an account?',style: TextStyle(color:Colors.grey),
                            ),
                            HoverUnderlineTextButton(
                              text: 'Login',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
