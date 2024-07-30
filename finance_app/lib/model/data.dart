class AuthenticatedUser {
  final String username;
  final String token;

  AuthenticatedUser({required this.username, required this.token});

  factory AuthenticatedUser.fromJson(Map<String, dynamic> json) {
    return AuthenticatedUser(
      username: json['username'],
      token: json['token'],
    );
  }
}

class AddUser {
  final String username;
  final String password;
  AddUser({required this.username, required this.password});
  factory AddUser.fromJson(Map<String, dynamic> json) {
    return AddUser(
      username: json['username'],
      password: json['password'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }


}

