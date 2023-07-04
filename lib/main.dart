import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/app/screens/chats/chat.dart';

import 'package:flash_chat/app/widgets/auth/auth.dart';
import 'package:flash_chat/app/screens/home_screen.dart';
import 'package:flash_chat/app/screens/introduction_screen.dart';
import 'package:flash_chat/app/screens/login_screen.dart';
import 'package:flash_chat/app/screens/register_screen.dart';

import 'package:flash_chat/firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData.dark(),
      initialRoute: Auth.route,
      routes: {
        LoginScreen.route: (context) => LoginScreen(),
        RegisterScreen.route: (context) => RegisterScreen(),
        IntroductionScreen.route: (context) => const IntroductionScreen(),
        HomeScreen.route: (context) => const HomeScreen(),
        Auth.route: (context) => const Auth(),
        Chat.route:(context) => const Chat()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
