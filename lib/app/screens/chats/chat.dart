import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/app/constants/color_const/color_const.dart';
import 'package:flash_chat/app/models/chat_model.dart';
import 'package:flash_chat/app/models/user_model.dart';
import 'package:flutter/material.dart';

final _fireStore = FirebaseFirestore.instance;
User? loggedInUser;

class Chat extends StatefulWidget {
  const Chat({Key? key, required this.userModel}) : super(key: key);
  static const String route = 'chat';
  final UserModel? userModel;
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
        body: InkWell(
          onTap: () => Navigator.pop(context),
          child: SafeArea(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // list
              MessageStream(),

              //input field
              // const Expanded(child: SizedBox()),
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
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          onChanged: (value) {
                            messageText = value;
                          },
                          cursorColor: cRegisterColor,
                          style: const TextStyle(
                              color: cRegisterColor,
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
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
                        if (messageText!.isNotEmpty) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          final chatModel = ChatModel(
                              createdAt: Timestamp.now(),
                              message: messageController.text,
                              userName: loggedInUser!.email,
                              sender: widget.userModel!.name,
                              senderId: widget.userModel!.id);

                          messageController.clear();
                          _fireStore
                              .collection('messages')
                              .add(chatModel.toJson());
                          messageController.clear();
                        }
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
          )),
        ));
  }
}

class MessageStream extends StatelessWidget {
  MessageStream({super.key});
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('messages')
      .orderBy('createdAt', descending: false)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return Expanded(
          child: ListView(
            // shrinkWrap: true,

            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              final data = document.data()! as Map<String, dynamic>;
              return ListTile(
                title: MessageBuble(
                    sender: data['sender'],
                    text: data['message'],
                    isMe: loggedInUser!.email == data['userName']),
              );
            }).toList(),
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
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
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
                      topRight: Radius.circular(13),
                      topLeft: Radius.circular(13),
                      bottomLeft: Radius.circular(13),
                    )
                  : const BorderRadius.only(
                      bottomRight: Radius.circular(13),
                      topRight: Radius.circular(13),
                      topLeft: Radius.circular(13)),
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
