import 'package:flutter/material.dart';

class BottomTitle extends StatelessWidget {
  BottomTitle(
      {super.key,
      required this.title,
      required this.titleButton,
      required this.onPressed});
  final String title;
  final String titleButton;
  Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            titleButton,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.blue[500]),
          ),
        ),
      ],
    );
  }
}
