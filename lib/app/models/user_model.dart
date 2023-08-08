import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String name;
  final String email;
  final String id;

  UserModel({
    required this.email,
    required this.name,
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'id': id,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json['email'],
        id: json['id'],
        name: json['name'],
      );

  @override
  // TODO: implement props
  List<Object?> get props => [name, email, id];
}
