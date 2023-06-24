import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/app/resources/buttons/register_button.dart';
import 'package:flash_chat/app/screens/home_screen.dart';
import 'package:flash_chat/app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../constants/color_const/color_const.dart';
import '../constants/widget_const/widget_const.dart';
import '../resources/appBar_helper/app_bar_container.dart';
import '../resources/buttons/bottom_title.dart';
import '../resources/textfield_helper/my_textfield.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);
  static const String route = 'sign up';
  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final users = FirebaseFirestore.instance.collection('users');
  bool passToggle = true;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

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
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      isLoading = true;
    });
    // make sure password match

// creating user
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: usernameController.text, password: passwordController.text)
          .then((value) => {addUser()})
          .then((value) => Navigator.pushNamed(context, HomeScreen.route));
      isLoading = false;
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        displayMessage('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        displayMessage('The account already exists for that email.');
      }
    }
  }

  void displayMessage(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                message,
                style: const TextStyle(color: cWhiteColor),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: cRegisterColor.withOpacity(0.6),
        body: isLoading == true ? Center(child: LoadingAnimationWidget.hexagonDots(color: cGreyColor, size: 70)) : Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  reverse: true,
                  child: Column(
                    children: [
                      // AppBar
                      const AppBarContainer(
                        label: 'Register',
                        color: cRegisterColor,
                        definition: 'Fill up your details to register.',
                      ),
                      //email
                      cSizedBox50,
                      const Hero(
                        tag: 'logo',
                        child: Text(
                          '⚡',
                          style: TextStyle(fontSize: 80),
                        ),
                      ),
                      cSizedBox50,

                      MyTextField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        labelText: 'Name',
                        obscureText: false,
                        hintText: 'enter your name',
                        validator: (name) {
                          if (name!.isEmpty) {
                            return 'Enter your name';
                          }
                          return null;
                        },
                      ),
                      // Login button

                      cSizedBox30,
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
                      cSizedBox30,
                      MyTextField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        labelText: 'password',
                        obscureText: passToggle,
                        hintText: 'enter your password',
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
                            passToggle
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: cWhiteColor,
                          ),
                        ),
                      ),
                      // mobile number
                      cSizedBox30,
                      MyTextField(
                        controller: confirmPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        labelText: 'confirm password',
                        obscureText: false,
                        hintText: 'enter to confirm your password',
                        validator: (confirm) {
                          if (confirm != passwordController.text) {
                            return 'Your password don\'t match';
                          }
                          return null;
                        },
                        
                      ),
                      // mobile number
                      cSizedBox50,

                      // Login button
                      // const Expanded(child: cSizedBox50),
                      RegisterButton(
                          title: 'Register',
                          color: Colors.grey[900],
                          onTap: signUp),
                      cSizedBox20,
                      // Text
                      BottomTitle(
                          title: 'Already have an account ',
                          titleButton: 'Login',
                          onPressed: () {
                            Navigator.pushNamed(context, LoginScreen.route);
                          }),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
