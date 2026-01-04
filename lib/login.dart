import 'package:flutter/material.dart';
import 'package:littup/home.dart';
import 'package:littup/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';




class HoverUnderlineTextButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;

  const HoverUnderlineTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color=Colors.blue,
  });

  @override
  State<HoverUnderlineTextButton> createState() =>
      _HoverUnderlineTextButtonState();
}

class _HoverUnderlineTextButtonState
    extends State<HoverUnderlineTextButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Text(
widget.text,

      
          style: TextStyle(
            color: widget.color,
            fontWeight: FontWeight.w500,
            decoration:
                _hovered ? TextDecoration.underline : TextDecoration.none,
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  
@override
  State<LoginPage> createState() =>_LoginPageState();

}


class _LoginPageState extends State<LoginPage>{
  final _formKey=GlobalKey<FormState>();
   final  emailController=TextEditingController();
  final  passwordController=TextEditingController();


  bool isLoading=false;
  bool _obscurePassword=true;

  Future<void>signInWithEmail() async{
    if(!_formKey.currentState!.validate())
    return;
    setState(()=>isLoading=true);

    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text,
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const HomePage()),
      );
    }on FirebaseAuthException catch (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message??'Login failed')),
      );
    }finally{
      setState(()=>isLoading=false);
    }
  }
Future<void>signInWithGoogle() async{
  try{
    final  googleUser= await GoogleSignIn().signIn();
    if(googleUser==null) return ;

    final googleAuth=await googleUser.authentication;
  
    final credential=GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
     await FirebaseAuth.instance.signInWithCredential(credential);
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const HomePage()),
     );
  }catch(e){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Google sign-in failed')),
      );
  }
}
Future<void> resetPassWord()async{
  if(emailController.text.trim().isEmpty){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Enter your email first')),
    );
    return;
  }
  try{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim(),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password reset email sent')),
    );
  }catch(_){
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to send reset email')),
    );
  }
}
  @override
Widget build(BuildContext context){
      return Scaffold(
      backgroundColor: const Color.fromARGB(255, 199, 228, 255),
        body: Center(
          child: SingleChildScrollView(
          child: SizedBox(
            width: 380,
            child:Card(
              color: Colors.white,
              child:Padding(padding: 
              const EdgeInsets.all(20),
              child:Form(
                
              key:_formKey,
              child:Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 25,
              child: Icon(Icons.edit, color: Colors.white, size: 32),
              ),
                const SizedBox(height: 15),

              const Text("Welcome back",style: TextStyle(fontSize:20,fontWeight:  FontWeight.w600),),
                const SizedBox(height: 6),
                const Text('Login to your account',
                style: TextStyle(color:Colors.grey),
                ),
                const SizedBox(height: 25,),
              
                
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      
                    ),
                    validator: (value){
                      if(value==null||value.isEmpty){
                        return 'Email is required';
                      }
                      if(!value.contains('@')){
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15,),
                
                   TextFormField(
                    controller: passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                        _obscurePassword?
                        Icons.visibility_off
                        :Icons.visibility,
                      ),
                        onPressed: (){
                        setState(() {
                          _obscurePassword=!_obscurePassword;
                        });
                      }, 
                      ),
                      ),
                      validator: (value){
                        if(value==null||value.isEmpty){
                          return 'Password is required';
                        }
                        if(value.length<6){
                          return 'Minimum 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8,),
                    Align(
                      alignment: Alignment.centerRight,
                      child:HoverUnderlineTextButton(text: 'Forgot password', onPressed: resetPassWord,),
                    ),
                    const SizedBox(height: 20,),
                  
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                     onPressed: isLoading?null:signInWithEmail,
                     child: isLoading
                     ?
                     const CircularProgressIndicator(
                      color:Colors.white,
                     ):const Text('Log in',
                     style: TextStyle(color: Colors.white, fontSize: 16),),
                     ),
                    ),
                    
                const SizedBox(height: 15),
                SizedBox(
                  
  width: double.infinity,
  height: 48,
  child: OutlinedButton(
   
    onPressed: signInWithGoogle,
    child: const Text('Continue with Google'),
  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an acount?"),
                    HoverUnderlineTextButton(text: 'Sign Up', onPressed: (){

                   
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignupPage(),
          ),
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
          ),
        ),
     
   
      
          
      );
}
}