import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/app/constants/color_const/color_const.dart';
import 'package:flash_chat/app/models/chat_model.dart';
import 'package:flutter/material.dart';

final _fireStore = FirebaseFirestore.instance;
User? loggedInUser;

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);
  static const String route = 'chat';

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final messageController = TextEditingController();
  String? messageText;
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != loggedInUser) {
        loggedInUser = user;
      }
    } catch (e) {
      log('$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: cRegisterColor,
          title: const Text('chat'),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MessageStream(),
            const Expanded(child: SizedBox()),
            Container(
              decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: cRegisterColor))),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 13, vertical: 10),
                      child: TextField(
                        onChanged: (value) {
                          messageText = value;
                        },
                        cursorColor: cRegisterColor,
                        style: const TextStyle(
                            color: cRegisterColor, fontSize: 17),
                        controller: messageController,
                        decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: cRegisterColor, width: 1.5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(28))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: cRegisterColor, width: 1.5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(28))),
                            hintText: ' Type your message here ...',
                            hintStyle: TextStyle(color: cRegisterColor)),
                      ),
                    ),
                  ),
                  FloatingActionButton.small(
                    heroTag: '1',
                    backgroundColor: cRegisterColor,
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      final chatModel = ChatModel(
                          createdAt: Timestamp.now(),
                          message: messageController.text,
                          userName: loggedInUser!.email);
                      messageController.clear();
                      _fireStore.collection('messages').add(chatModel.toJson());
                    },
                    child: const Icon(
                      Icons.send,
                      color: cWhiteColor,
                      size: 20,
                    ),
                  )
                ],
              ),
            ),
          ],
        )));
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('messages').snapshots(),
      builder: (context,  snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: cRegisterColor,
            ),
          );
        }
        final messages = snapshot.data.documents.reversed;
        List<MessageBuble> messageBubbles = [];
        for (var message in messages) {
          final messageText = message.data['text'];
          final messageSender = message.data['sender'];

          final currentUser = loggedInUser!.email;

          final messageBubble = MessageBuble(
            sender: messageSender,
            text: messageText,
            isMe: currentUser == messageSender,
          );

          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBuble extends StatelessWidget {
  const MessageBuble(
      {super.key,
      required this.sender,
      required this.text,
      required this.isMe});
  final String sender;
  final String text;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              sender,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
            Material(
              borderRadius: isMe
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))
                  : const BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
              elevation: 5,
              color: isMe ? cRegisterColor : Colors.white54,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 15, color: isMe ? cWhiteColor : Colors.black54),
                ),
              ),
            )
          ]),
    );
  }
}
