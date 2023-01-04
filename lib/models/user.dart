class User {
  int? id;
  String? resetKey;

  User({
    this.id,
    this.resetKey = '',
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resetKey = json['resetKey'];
  }
}
