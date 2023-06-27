import 'package:flutter/material.dart';

import '../../constants/color_const/color_const.dart';

class MyUserAvatar{
    Padding buildUserAvatar(String name, String fillImageName) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          UserAvatar(fillImageName: fillImageName),
          const SizedBox(
            height: 5,
          ),
          Text(
            name,
            style: const TextStyle(color: cWhiteColor, fontSize: 16),
          )
        ],
      ),
    );
  }
}
class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.fillImageName,
  });
  final String fillImageName;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundColor: cWhiteColor,
        radius: 32,
        child: CircleAvatar(
          radius: 29,
          backgroundImage: Image.asset('assets/images/$fillImageName').image,
        ));
  }
}


