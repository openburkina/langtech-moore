class KeyAndPassword {
  String? key;
  String? newPassword;

  KeyAndPassword({
    this.key,
    this.newPassword,
  });

  Map<String, dynamic> toJon() => {
        "key": key,
        "newPassword": newPassword,
      };
}
