import 'package:firebase_auth/firebase_auth.dart';

import 'package:flash_chat/app/resources/buttons/register_button.dart';
import 'package:flash_chat/app/screens/home_screen.dart';
import 'package:flash_chat/app/screens/register_screen.dart';
import 'package:flutter/material.dart';

import '../constants/color_const/color_const.dart';
import '../constants/widget_const/widget_const.dart';
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
  bool passToggle = false;

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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: cLoginColor.withOpacity(0.6),
        body: Form(
          key: _formKey,
          child: Column(
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
                validator: (value) {
                  bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value!);
                  if (value.isEmpty) {
                    return 'Enter your email';
                  }
                  if (!emailValid) {
                    return 'Enter valid email';
                  }
                 return null;
                },
              ),
              //password
              cSizedBox50,
              MyTextField(
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                labelText: 'password',
                obscureText: passToggle,
                validator: (password) {
                  if (password!.isEmpty) {
                    return 'Enter your password';
                  } else if (passwordController.text.length < 6) {
                    return 'Password should be more than 6 characters';
                  }
                   return null;
                },
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      passToggle = !passToggle;
                    });
                  },
                  child: Icon(
                    passToggle ? Icons.visibility_off : Icons.visibility,
                    color: cWhiteColor,
                  ),
                ),
                hintText: 'enter your password',
              ),
              // Login button
              const Expanded(child: cSizedBox50),
              RegisterButton(
                  title: 'Login',
                  color: Colors.grey[900],
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      signIn();
                    }
                  }),
              cSizedBox20,
              // Text Don't have an account
              BottomTitle(
                title: 'Don\'t have an account',
                titleButton: 'Register',
                onPressed: () =>
                    Navigator.pushNamed(context, RegisterScreen.route),
              ),
              // Row(
              //   children: [
              //     InkWell(child: Image.asset('assets/images/logo.png',scale: 10,))
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
