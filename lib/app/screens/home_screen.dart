import 'package:flash_chat/app/constants/color_const/color_const.dart';

import 'package:flash_chat/app/widgets/appBar_helper/nav_bar_drawer.dart';
import 'package:flash_chat/app/widgets/user_avatar/user_avatar.dart';
import 'package:flash_chat/app/widgets/user_card.dart';
import 'package:flutter/material.dart';

MyUserAvatar userAvatar = MyUserAvatar();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String route = 'home page';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: cRegisterColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: cWhiteColor,
          drawer: const NavBarDrawer(),
          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: cRegisterColor,
            ),
            elevation: 0,
            backgroundColor: cWhiteColor,
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search_sharp,
                    size: 25,
                  )),
            ],
            title: const Text(
              'FLASH CHAT',
              style:
                  TextStyle(color: cRegisterColor, fontWeight: FontWeight.bold),
            ),
          ),
          body: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.only(top: 20, right: 25, left: 25),
                  height: 220,
                  decoration: const BoxDecoration(
                    color: cRegisterColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Favourite contacts',
                            style: TextStyle(color: cWhiteColor),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.more_horiz,
                                color: cWhiteColor,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 90,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            userAvatar.buildUserAvatar('Mr.X', 'mers.webp'),
                            userAvatar.buildUserAvatar('Mr.X', 'mers.webp'),
                            userAvatar.buildUserAvatar('Mr.X', 'mers.webp'),
                            userAvatar.buildUserAvatar('Mr.X', 'mers.webp'),
                            userAvatar.buildUserAvatar('Mr.X', 'mers.webp'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 170,
                right: 5,
                left: 5,
                bottom: 0,
                child: Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: ListView.builder(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .01),
                      physics: const BouncingScrollPhysics(),
                      itemCount: 16,
                      itemBuilder: ((context, index) {
                        return const UserCard();
                      })),
                ),
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: SizedBox(
            height: 65,
            width: 65,
            child: FloatingActionButton(
              backgroundColor: cRegisterColor,
              onPressed: () {},
              child: const Icon(
                Icons.edit_outlined,
                size: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
