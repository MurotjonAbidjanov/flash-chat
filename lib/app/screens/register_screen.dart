import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/app/constants/constants.dart';
import 'package:flash_chat/app/resources/buttons/register_button.dart';
import 'package:flash_chat/app/screens/home_screen.dart';
import 'package:flash_chat/app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import '../resources/appBar_helper/app_bar_container.dart';
import '../resources/buttons/bottom_title.dart';
import '../resources/textfield_helper/my_textfield.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final nameController = TextEditingController();

  final users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser() {
    return users
        .add({
          'name': nameController.text,
          'email': usernameController.text,
          // 'id':id,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  void signUp() async {
    FocusScope.of(context).unfocus();
    // make sure password match

// creating user
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: usernameController.text, password: passwordController.text)
          .then((value) => {addUser()})
          .then((value) => Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen())));
    } on FirebaseException catch (e) {
      displayMessage(e.code);
    }
  }

  void displayMessage(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(message),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: cRegisterColor.withOpacity(0.6),
        body: Column(
          children: [
            // AppBar
            AppBarContainer(
              label: 'Register',
              color: cRegisterColor,
              definition: 'Fill up your details to register.',
            ),
            //email
            const SizedBox(
              height: 50,
            ),
            MyTextField(
              controller: nameController,
              keyboardType: TextInputType.name,
              labelText: 'Name',
              obscureText: false,
              hintText: 'enter your name',
            ),
            // Login button

            cSizedBox50,
            MyTextField(
              controller: usernameController,
              keyboardType: TextInputType.emailAddress,
              labelText: 'email',
              obscureText: false,
              hintText: 'enter your email',
            ),
            //password
            cSizedBox50,
            MyTextField(
              controller: passwordController,
              keyboardType: TextInputType.visiblePassword,
              labelText: 'password',
              obscureText: true,
              hintText: 'enter your password',
            ),
            // mobile number
            cSizedBox50,

            // Login button
            const Expanded(child: cSizedBox50),
            RegisterButton(
                title: 'Register', color: Colors.grey[900], onTap: signUp),
            cSizedBox20,
            // Text
            BottomTitle(
                title: 'Already have an account ',
                titleButton: 'Login',
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }),
          ],
        ),
      ),
    );
  }
}
