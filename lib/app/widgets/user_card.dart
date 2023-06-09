import 'package:flash_chat/app/constants/color_const/color_const.dart';
import 'package:flash_chat/app/constants/widget_const/widget_const.dart';
import 'package:flutter/material.dart';

class UserCard extends StatefulWidget {
   UserCard({Key? key, this.onTap}) ;
  void Function()? onTap;
  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .03, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 1,
      child: ListTile(
        onTap:widget.onTap,
        // user profile picture
        leading: CircleAvatar(
          backgroundColor: cRegisterColor,
          radius: 25,
          child: CircleAvatar(
            radius: 23,
              backgroundImage: Image.asset('assets/images/mers.webp').image),
        ),

        // user name
        title: const Text('Demo User'),

        // last message
        subtitle: const Text(
          'Last user message',
          maxLines: 1,
        ),

        //last message time
        trailing: const Column(
          children: [
            Text(
              '12:00 PM',
              style: TextStyle(color: Colors.black54),
            ),
            cSizedBox10,
            CircleAvatar(
              backgroundColor: cRegisterColor,
              radius: 10,
              child: Text(
                '2',
                style: TextStyle(fontSize: 13, color: cWhiteColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
