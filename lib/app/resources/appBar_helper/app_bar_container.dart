import 'package:flash_chat/app/screens/introduction_screen.dart';
import 'package:flutter/material.dart';
import '../../constants/color_const/color_const.dart';

class AppBarContainer extends StatelessWidget {
  const AppBarContainer({
    super.key,
    required this.color,
    required this.label,
    required this.definition,
  });
  final Color color;
  final String label;
  final String definition;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(60)),
          color: color),
      child: Stack(
        children: [
          Positioned(
              left: 0,
              top: 10,
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, IntroductionScreen.route);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 36,
                  color: cWhiteColor,
                ),
              )),
          Positioned(
            left: 20,
            top: 70,
            child: Text(
              label,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: cWhiteColor),
            ),
          ),
          Positioned(
            width: 260,
            height: 40,
            left: 20,
            top: 120,
            child: Text(
              definition,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: cWhiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
