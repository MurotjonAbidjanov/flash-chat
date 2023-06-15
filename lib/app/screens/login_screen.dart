import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/app/constants/constants.dart';
import 'package:flash_chat/app/resources/buttons/register_button.dart';
import 'package:flash_chat/app/screens/home_screen.dart';
import 'package:flash_chat/app/screens/register_screen.dart';
import 'package:flutter/material.dart';

import '../resources/appBar_helper/app_bar_container.dart';
import '../resources/buttons/bottom_title.dart';
import '../resources/textfield_helper/my_textfield.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  static const String route = 'log in';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() async {
    try {
      FocusScope.of(context).unfocus();
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: usernameController.text, password: passwordController.text)
          .then((value) => Navigator.pushNamed(context, HomeScreen.route));
    } on FirebaseAuthException catch (e) {
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
              height: 50,
            ),
            const Hero(
              tag: 'logo',
              child: Text(
                '⚡',
                style: TextStyle(fontSize: 80),
              ),
            ),

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
            // Login button
            const Expanded(child: cSizedBox50),
            RegisterButton(
                title: 'Login', color: Colors.grey[900], onTap: signIn),
            cSizedBox20,
            // Text Don't have an account
            BottomTitle(
              title: 'Don\'t have an account',
              titleButton: 'Register',
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterScreen())),
            ),
            // Row(
            //   children: [
            //     InkWell(child: Image.asset('assets/images/logo.png',scale: 10,))
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
