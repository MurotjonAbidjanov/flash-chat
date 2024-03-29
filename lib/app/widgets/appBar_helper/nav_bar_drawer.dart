import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/app/constants/textStyle_const/text_style_const.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
            buildHeader(),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }
}

class buildHeader extends StatefulWidget {
  const buildHeader({super.key});

  @override
  State<buildHeader> createState() => _buildHeaderState();
}

class _buildHeaderState extends State<buildHeader> {
  XFile? _imageFile;
  dynamic pickedImageEror;
  late String profileImage;
  final ImagePicker imagePicker = ImagePicker();

  void _pickImageFromCamera() async {
    try {
      final picKedImage = await imagePicker.pickImage(
        imageQuality: 95,
        maxHeight: 300,
        maxWidth: 300,
        source: ImageSource.camera,
      );

      setState(() {
        _imageFile = picKedImage;
      });
    } catch (e) {
      setState(() {
        pickedImageEror = e;
      });
    }
  }

  void _pickImageFromGallery() async {
    try {
      final picKedImage = await imagePicker.pickImage(
        imageQuality: 95,
        maxHeight: 300,
        maxWidth: 300,
        source: ImageSource.gallery,
      );

      setState(() {
        _imageFile = picKedImage;
      });
    } catch (e) {
      setState(() {
        pickedImageEror = e;
      });
    }
  }

  void showPhotoOptions() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Upload Profile Picture'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    _pickImageFromGallery();
                  },
                  leading: const Icon(Icons.photo_album),
                  title: const Text("Select from Gallery"),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    _pickImageFromCamera();
                  },
                  leading: const Icon(Icons.photo_camera),
                  title: const Text("Take a photo"),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .27,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/drawerAppBar.jpeg'),
            fit: BoxFit.cover),
      ),
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height * .01,
            right: MediaQuery.of(context).size.width * 0.2,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: _imageFile == null
                      ? null
                      : FileImage(
                          File(_imageFile!.path),
                        ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'mr.X',
                  style: TextStyle(fontSize: 28, color: cWhiteColor),
                ),
                const Text(
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
              onPressed: () {
                showPhotoOptions();
              },
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
    ;
  }
}

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
