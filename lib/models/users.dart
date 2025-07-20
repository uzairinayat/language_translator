class User {
  final String email;
  final String? password;
  final String? name;

  User({required this.email, this.password, this.name});

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'name': name,
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      password: json['password'],
      name: json['name'],
    );
  }
}