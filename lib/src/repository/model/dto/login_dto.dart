class LoginDTO {
  final String email;
  final String password;

  LoginDTO({
    required this.email,
    required this.password,
  });

  factory LoginDTO.fromJson(Map<String, dynamic> json) => LoginDTO(
        email: json['email'] as String,
        password: json['password'] as String,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}
