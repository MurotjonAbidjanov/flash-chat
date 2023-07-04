import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/app/models/user_model.dart';

import 'package:flash_chat/app/widgets/buttons/register_button.dart';
import 'package:flash_chat/app/screens/home_screen.dart';
import 'package:flash_chat/app/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../constants/color_const/color_const.dart';
import '../constants/widget_const/widget_const.dart';
import '../widgets/appBar_helper/app_bar_container.dart';
import '../widgets/buttons/bottom_title.dart';
import '../widgets/textfield_helper/my_textfield.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  static const String route = 'log in';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool passToggle = true;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void signIn() async {
    setState(() {
      isLoading = true;
    });
    try {
      FocusScope.of(context).requestFocus(FocusNode());
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: usernameController.text, password: passwordController.text)
          .then((value) => Navigator.pushNamed(context, HomeScreen.route));
      isLoading = false;
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
        body: isLoading == true
            ? Center(
                child: LoadingAnimationWidget.hexagonDots(
                    color: cGreyColor, size: 70))
            : Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  children: [
                    // AppBar
                    const AppBarContainer(
                      label: 'Login',
                      color: cLoginColor,
                      definition: 'Enter your parametrs to continue',
                    ),
                    //email
                    const SizedBox(
                      height: 50,
                    ),
                    const Flexible(
                      child: Hero(
                        tag: 'logo',
                        child: Text(
                          '⚡',
                          style: TextStyle(fontSize: 80),
                        ),
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
                    cSizedBox50,
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
