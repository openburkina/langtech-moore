import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:langtech_moore_mobile/config/http/urls.dart';
import 'package:langtech_moore_mobile/models/loginVM.dart';

class Http {
  static Future onAuthenticate(LoginVM loginVM) async {
    return await http.post(Uri.parse(Urls.LOGIN_URL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(loginVM.toJson()));
  }
}
