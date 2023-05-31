import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/constants/constants.dart';
import 'package:flash_chat/resources/register_button.dart';
import 'package:flash_chat/screens/home_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flutter/material.dart';

import '../resources/app_bar_container.dart';
import '../resources/bottom_title.dart';
import '../resources/my_textfield.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  final username = TextEditingController();
  final password = TextEditingController();
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
            const MyTextField(
              controller: username,
              keyboardType: TextInputType.emailAddress,
              labelText: 'username',
              obscureText: false,
              hintText: 'enter your username',
            ),
            //password
            cSizedBox50,
            const MyTextField(
              keyboardType: TextInputType.visiblePassword,
              labelText: 'password',
              obscureText: true,
              hintText: 'enter your password',
            ),
            // mobile number
            cSizedBox50,
            const MyTextField(
              keyboardType: TextInputType.phone,
              labelText: 'mobile',
              obscureText: true,
              hintText: 'enter your mobile number',
            ),
            // Login button
            const Expanded(child: cSizedBox50),
            RegisterButton(
                title: 'Register',
                color: Colors.grey[900],
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                }),
            cSizedBox20,
            // Text
            BottomTitle(
                title: 'Already have an account ',
                titleButton: 'Login',
                onPressed: () {
                  FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: username.text, password: password.text);

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }),
          ],
        ),
      ),
    );
  }
}
