class UserModel{
  final String?name;
  final String?email;
  final String?id;


  UserModel(this.email, this.name, this.id,);


   Map<String, dynamic> toJson() {
    return{
      'name': name,
      'email': email,
      'id':id,
    };
   }

}