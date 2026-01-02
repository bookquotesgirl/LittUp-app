import 'package:flutter/material.dart';
// import 'home.dart';
import 'login.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      title: 'LittUp',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 255, 255)),
      ),
      home: const SplashScreen(title: 'LittUp'),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.title});
   final String title;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginPage()));

    });
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 7, 255, 222),
      body: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.edit, 
          size: 100,
          color: Colors.black,
            ),
            SizedBox(height: 20),
            Text(
              'Create your own stories',
              style: TextStyle( fontSize: 24, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        )
    );
  }
}