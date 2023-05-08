import 'package:flash_chat/constants/constants.dart';
import 'package:flash_chat/resources/register_button.dart';
import 'package:flutter/material.dart';

import '../resources/app_bar_container.dart';
import '../resources/my_textfield.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final usernameController = TextEditingController();
  // final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: cLoginColor.withOpacity(0.6),
        body: Column(
          children: [
// AppBar
             AppBarContainer(label: 'Login',color: cLoginColor,definition: 'Enter your parametrs to continue',),
//email
            const SizedBox(
              height: 100,
            ),
            const MyTextField(
              labelText: 'username',
              obscureText: false,
              hintText: 'enter your username',
            ),
//password
            cSizedBox50,
             const MyTextField(
              labelText: 'password',
              obscureText: true,
              hintText: 'enter your password',
            ),
// Login button
            const Expanded(child: cSizedBox50),
            RegisterButton(
                title: 'Login', color: Colors.grey[900], onTap: () {}),
            cSizedBox20
          ],
        ),
      ),
    );
  }
}
