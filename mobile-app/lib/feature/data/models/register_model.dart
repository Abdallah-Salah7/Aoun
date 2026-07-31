class RegisterModel {

  final String fullName;
  final String email;
  final String password;
  final String confirmPassword;
  final String accountType;

  RegisterModel({

    required this.fullName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.accountType,
  });

  Map<String, dynamic> toJson() {

    return {

      "fullName": fullName,
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword,
      "accountType": accountType,
    };
  }
}