import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/constants/constants.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/register_screen.dart';
import 'package:flutter/material.dart';

import '../resources/register_button.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            cSizedBox20,
            // 'Flash Chat' text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '⚡',
                  style: TextStyle(fontSize: 40),
                ),
                DefaultTextStyle(
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 51,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 3),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText(
                        'Flash Chat',
                      ),
                    ],
                    repeatForever: true,
                  ),
                ),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
            // Login button
            const SizedBox(
              height: 40,
            ),
            RegisterButton(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen())),
              color: cLoginColor,
              title: 'Login',
            ),

            //Register button
            const SizedBox(
              height: 25,
            ),
            RegisterButton(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterScreen())),
              color: cRegisterColor,
              title: 'Register',
            )
          ],
        ),
      ),
    );
  }
}
