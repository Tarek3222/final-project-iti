class UserModel {
   String email;
   String password;
   String name;
   String phone;
  String? id;
  String image;

  UserModel({
    this.id,
    required this.email,
    required this.password,
    this.image='',
    required this.name,
    required this.phone,
  });

}