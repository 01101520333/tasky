class AppUser {
  AppUser({this.name, this.email, this.phone, this.password, this.id});

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      name: json["name"] as String,
      email: json["email"] as String,
      phone: json["phone"] as String,
      password: json["password"] as String,
      id: json["id"],
    );
  }

  String? name;
  String? email;
  String? phone;
  String? password;
  String? id;

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "password": password,
      "id": id,
    };
  }
}
