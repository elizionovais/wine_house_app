class UserModel {
  String? name;
  String? email;
  String? phone;
  String? cpf;
  String? password;
  String? id;
  String? token;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.cpf,
    this.password,
    this.id,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['fullname'],
      email: json['email'],
      phone: json['phone'],
      cpf: json['cpf'],
      password: json['password'],
      id: json['id'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullname': name,
      'email': email,
      'phone': phone,
      'cpf': cpf,
      'password': password,
      'id': id,
      'token': token,
    };
  }
}
