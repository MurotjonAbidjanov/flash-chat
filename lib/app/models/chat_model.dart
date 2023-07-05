import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChatModel extends Equatable {
  // final String? sender;
  // final String? senderId;
  final String? message;
  final String? userName;
  final Timestamp? createdAt;

  ChatModel(
      {
      //   this.sender,
      // this.senderId,
      this.message,
      this.userName = '',
      this.createdAt});

  Map<String, dynamic> toJson() => {
        // 'sender': sender,
        // 'senderId': senderId,
        'message': message,
        'userName': userName,
        'createdAt': Timestamp.now()
      };

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      // sender: json['sender'],
      // senderId: json['senderId'],
      message: json['message'].toString(),
      userName: json['userName'].toString(),
      createdAt: json['createdAt'],
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [message, userName, createdAt];
}
