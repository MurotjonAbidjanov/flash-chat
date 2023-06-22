import 'package:flash_chat/app/constants/color_const/color_const.dart';
import 'package:flash_chat/app/resources/appBar_helper/nav_bar_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String route = 'home page';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: cRegisterColor,
          drawer: const NavBarDrawer(),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: cRegisterColor,
            centerTitle: true,
            title: const Text('FLASH CHAT'),
          ),
          body: Container(
            height: double.infinity,
            width: 420,
            decoration: const BoxDecoration(
              color: cWhiteColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(50),
              ),
            ),
            child: const Center(
              child: Text(
                "data",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
          )),
    );
  }
}
