import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/app/constants/constants.dart';
import 'package:flutter/material.dart';

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
      color: cRegisterColor,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: const Column(
        children: [
          CircleAvatar(
            radius: 52,
            backgroundImage: AssetImage(
              'assets/images/mers.webp',
            ),
          ),
          SizedBox(
            height: 12,
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
    );

Widget buildMenuItems(BuildContext context) => Container(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        runSpacing: 16,
        children: [
          ListTile(
            leading: const Icon(
              Icons.home_outlined,
              color: Colors.black,
            ),
            title: Text(
              'home'.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.favorite,
              color: Colors.black,
            ),
            title: Text(
              'favorites'.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.workspaces_outline,
              color: Colors.black,
            ),
            title: Text(
              'workFlow'.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.update,
              color: Colors.black,
            ),
            title: Text(
              'Updates'.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            onTap: () {},
          ),
          const Divider(
            color: Colors.black87,
            height: 5,
          ),
          ListTile(
            leading: const Icon(
              Icons.account_tree_outlined,
              color: Colors.black,
            ),
            title: Text(
              'plugins'.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.notifications,
              color: Colors.black,
            ),
            title: Text(
              'notifications'.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            onTap: () {},
          ),
          const SizedBox(
            height: 150,
          ),
          ListTile(
              title: Center(
                child: Text(
                  'log out'.toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.red),
                ),
              ),
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) =>
                    Navigator.pushNamed(context, IntroductionScreen.route));
              }),
        ],
      ),
    );
