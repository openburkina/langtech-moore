class Password {
  String? currentPassword;
  String? newPassword;
  Password({
    this.currentPassword,
    this.newPassword,
  });

  Map<String, dynamic> toJson() => {
    'currentPassword': currentPassword,
    'newPassword': newPassword,
  };
}