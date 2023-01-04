class MResponse {
  late String? code;
  late String? msg;

  MResponse({
    this.code,
    this.msg,
  });

  MResponse.fromJson(Map<String, dynamic> json) {
    this.code = json["code"];
    this.msg = json["msg"];
  }
}
