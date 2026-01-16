import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:littup/home.dart';
import 'package:littup/login.dart';
import 'package:littup/profilePage.dart';
import '../writePage.dart';

class LittAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LittAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Widget _navButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Widget page,
  }) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },
      icon: Icon(icon, color: Colors.white, size: 18),
      label: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }

  void _handleMenuSelection(BuildContext context, String value) {
    if (value == 'home') {
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
    } else if (value == 'write') {
      Navigator.push(context, MaterialPageRoute(builder: (_) => Writepage()));
    } else if (value == 'profile') {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const Profilepage()));
    } else if (value == 'logout') {
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>LoginPage()  ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 700;

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
                backgroundColor: Color.fromARGB(255, 22, 193, 184),
                child: Icon(Icons.edit, color: Colors.white, size: 18),
              ),
              SizedBox(width: 8),
              Text(
                'LittUp',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          // Right side
          if (!isMobile)
            Row(
              children: [
                _navButton(
                  context,
                  icon: Icons.home_outlined,
                  label: 'Home',
                  page: HomePage(),
                ),
                const SizedBox(width: 10),
                _navButton(
                  context,
                  icon: CupertinoIcons.pen,
                  label: 'Write',
                  page: Writepage(),
                ),
                const SizedBox(width: 10),
                _navButton(
                  context,
                  icon: Icons.person_2_outlined,
                  label: 'Profile',
                  page: const Profilepage(),
                ),
                const SizedBox(width: 10),

                PopupMenuButton<String>(
                  tooltip: 'Account',
                  onSelected: (value) => _handleMenuSelection(context, value),
                  itemBuilder: (context) => const [
                    PopupMenuItem(value: 'logout', child: Text('Logout')),
                  ],
                  child: const CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.black,
                    child: Icon(Icons.person, color: Colors.white, size: 18),
                  ),
                ),
              ],
            )
          else
            // Mobile menu
            PopupMenuButton<String>(
              icon: const Icon(Icons.menu, color: Colors.black),
              onSelected: (value) => _handleMenuSelection(context, value),
              itemBuilder: (context) => const [
                PopupMenuItem(value: 'home', child: Text('Home')),
                PopupMenuItem(value: 'write', child: Text('Write')),
                PopupMenuItem(value: 'profile', child: Text('Profile')),
                PopupMenuItem(value: 'logout', child: Text('Logout')),
              ],
            ),
        ],
      ),
    );
  }
}
