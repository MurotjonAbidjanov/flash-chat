import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/app/resources/appBar_helper/nav_bar_drawer.dart';
import 'package:flash_chat/app/screens/introduction_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void signOut(){
    FirebaseAuth.instance.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarDrawer(),
      appBar: AppBar(
        actions: [IconButton(
          onPressed: signOut,
          icon: Icon(Icons.logout),)],
        centerTitle: true,
        title: Text('WELCOME'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => IntroductionScreen())),
          child: Text(
            'log out',
            style: TextStyle(fontSize: 28),
          ),
        ),
      ),
    );
  }
}
