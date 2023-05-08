import 'package:flash_chat/constants/constants.dart';
import 'package:flash_chat/resources/register_button.dart';
import 'package:flutter/material.dart';

import '../resources/app_bar_container.dart';
import '../resources/my_textfield.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
// mobile number
 cSizedBox50,
            const MyTextField(
              labelText: 'mobile',
              obscureText: true,
              hintText: 'enter your mobile number',
            ),
// Login button
            const Expanded(child: cSizedBox50),
            RegisterButton(
                title: 'Register', color: Colors.grey[900], onTap: () {}),
            cSizedBox20

          ],
        ),
      ),
    );
  }
}
