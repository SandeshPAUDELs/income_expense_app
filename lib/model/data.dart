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

