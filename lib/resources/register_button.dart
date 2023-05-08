import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  RegisterButton(
      {super.key,
      required this.title,
      required this.color,
      required this.onTap});

  String title = '';
  Color? color;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 59,
        width: 345,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: color),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.w400, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
