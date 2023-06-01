import 'package:flash_chat/constants/constants.dart';
import 'package:flash_chat/resources/register_button.dart';
import 'package:flash_chat/screens/register_screen.dart';
import 'package:flutter/material.dart';

import '../resources/app_bar_container.dart';
import '../resources/bottom_title.dart';
import '../resources/my_textfield.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: cLoginColor.withOpacity(0.6),
        body: Column(
          children: [
            // AppBar
            AppBarContainer(
              label: 'Login',
              color: cLoginColor,
              definition: 'Enter your parametrs to continue',
            ),
            //email
            const SizedBox(
              height: 100,
            ),
            MyTextField(
              onChanged: (value) {
                value = username;
              },
              keyboardType: TextInputType.emailAddress,
              labelText: 'username',
              obscureText: false,
              hintText: 'enter your username',
            ),
            //password
            cSizedBox50,
            MyTextField(
              onChanged: (value) {
                value = password;
              },
              keyboardType: TextInputType.visiblePassword,
              labelText: 'password',
              obscureText: true,
              hintText: 'enter your password',
            ),
            // Login button
            const Expanded(child: cSizedBox50),
            RegisterButton(
                title: 'Login', color: Colors.grey[900], onTap: () {}),
            cSizedBox20,
            // Text Don't have an account
            BottomTitle(
              title: 'Don\'t have an account',
              titleButton: 'Register',
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterScreen())),
            ),
          ],
        ),
      ),
    );
  }
}
