class LoginVM {
  String? username;
  String? password;
  bool? rememberMe;

  LoginVM({
    this.username,
    this.password,
    this.rememberMe = true,
  });

  LoginVM.fromJson(Map<dynamic, String> json) {
    this.username = json['username'];
    this.password = json['password'];
    this.rememberMe = json['rememberMe'] as bool?;
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'rememberMe': rememberMe,
      };
}
