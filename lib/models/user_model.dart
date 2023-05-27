class UserModel {
  int? id;
  String? name;
  String? email;
  String? password;
  String? token;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.token,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'token': token,
    };
  }
}
