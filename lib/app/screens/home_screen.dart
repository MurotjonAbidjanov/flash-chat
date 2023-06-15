import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/app/constants/constants.dart';
import 'package:flash_chat/app/resources/appBar_helper/nav_bar_drawer.dart';
import 'package:flash_chat/app/screens/introduction_screen.dart';
import 'package:flutter/material.dart';

import '../resources/home_screen_helper/home_page_body_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String route = 'home page';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void signOut() {
    FirebaseAuth.instance.signOut().then(
        (value) => Navigator.pushNamed(context, IntroductionScreen.route));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        backgroundColor: cDarkBlue,
        drawer: const NavBarDrawer(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: cDarkBlue,
          bottom: const TabBar(
            indicatorColor: cWhiteColor,
            splashBorderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30), top: Radius.circular(30)),
            tabs: [
              Tab(
                text: 'chats',
              ),
              Tab(
                text: 'status',
              ),
              Tab(
                text: 'calls',
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: signOut,
              icon: Icon(Icons.logout),
            )
          ],
          centerTitle: true,
          title: Text('FLASH CHAT'),
        ),
        body: Column(
          children: [
            HomePageBodyContainer(
              height: 500,
              color: Colors.white70,
            )
          ],
        ),
      ),
    );
  }
}
