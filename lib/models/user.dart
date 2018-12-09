class User {
  final String email;
  final String password;
  final String id;
  final errMessage;

  User({this.email, this.password, this.id = "", this.errMessage = ""});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      id: json['_id'],
    );
  }

  factory User.formError(Map<String, dynamic> json) {
    return User(errMessage: json['errMessage']);
  }
}
