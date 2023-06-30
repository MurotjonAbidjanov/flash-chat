import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/app/constants/textStyle_const/text_style_const.dart';
import 'package:flutter/material.dart';
import '../../constants/color_const/color_const.dart';
import '../../constants/widget_const/widget_const.dart';
import '../../screens/introduction_screen.dart';

class NavBarDrawer extends StatefulWidget {
  const NavBarDrawer({Key? key}) : super(key: key);

  @override
  State<NavBarDrawer> createState() => _NavBarDrawerState();
}

class _NavBarDrawerState extends State<NavBarDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(40))),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }
}

Widget buildHeader(BuildContext context) => Container(
      height: MediaQuery.of(context).size.height * .27,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/drawerAppBar.jpeg'),
            fit: BoxFit.cover),
      ),
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Stack(
        children: [
          const Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage(
                    'assets/images/mers.webp',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'mr.X',
                  style: TextStyle(fontSize: 28, color: cWhiteColor),
                ),
                Text(
                  'test@gmail.com',
                  style: TextStyle(fontSize: 16, color: cWhiteColor),
                ),
                cSizedBox20
              ],
            ),
          ),
          Positioned(
            top: 100,
            right: 80,
            child: FloatingActionButton.small(
              backgroundColor: cWhiteColor,
              onPressed: () {},
              child: const Icon(
                Icons.camera_alt,
                color: cRegisterColor,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );

Widget buildMenuItems(BuildContext context) => Container(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        runSpacing: 16,
        children: [
          ListTile(
            leading: const Icon(
              Icons.home_outlined,
              color: cRegisterColor,
            ),
            title: Text('home'.toUpperCase(), style: cDrawerButtonsStyle),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.favorite,
              color: cRegisterColor,
            ),
            title: Text(
              'favorites'.toUpperCase(),
              style: cDrawerButtonsStyle,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
              color: cRegisterColor,
            ),
            title: Text(
              'edit profile'.toUpperCase(),
              style: cDrawerButtonsStyle,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.update,
              color: cRegisterColor,
            ),
            title: Text(
              'Updates'.toUpperCase(),
              style: cDrawerButtonsStyle,
            ),
            onTap: () {},
          ),
          const Divider(
            color: cRegisterColor,
            height: 5,
          ),
          ListTile(
            leading: const Icon(
              Icons.account_tree_outlined,
              color: cRegisterColor,
            ),
            title: Text(
              'plugins'.toUpperCase(),
              style: cDrawerButtonsStyle,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.notifications,
              color: cRegisterColor,
            ),
            title: Text(
              'notifications'.toUpperCase(),
              style: cDrawerButtonsStyle,
            ),
            onTap: () {},
          ),
          const SizedBox(
            height: 140,
          ),
          ListTile(
              title: Center(
                child: Text(
                  'log out'.toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, color: Color(0xfffa1000)),
                ),
              ),
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) =>
                    Navigator.pushNamed(context, IntroductionScreen.route));
              }),
        ],
      ),
    );
