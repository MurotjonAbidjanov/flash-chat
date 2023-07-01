import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/app/constants/color_const/color_const.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final message = TextEditingController();
  final chats = FirebaseFirestore.instance.collection('messages');
  Future<void> addMessage() {
    return chats
        .add({'messages': message.text})
        .then((value) => print("message sended"))
        .catchError((error) => print("Failed to send message: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cRegisterColor,
        title: Text('chat'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(child: SizedBox()),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: TextFormField(
                  controller: message,
                  decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: cRegisterColor, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(28))),
                      enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: cRegisterColor, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(28))),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            addMessage();
                          },
                          icon: const Icon(
                            Icons.send,
                            size: 25,
                            color: cRegisterColor,
                          ))),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
