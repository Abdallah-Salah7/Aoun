class LoginModel {
  final bool isSuccess;
  final String message;
  final String token;
  final String role;

  LoginModel({
    required this.isSuccess,
    required this.message,
    required this.token,
    required this.role,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      isSuccess: json['isSuccess'],
      message: json['message'],
      token: json['token'],
      role: json['role'],
    );
  }
}