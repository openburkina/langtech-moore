import 'dart:convert';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:langtech_moore_mobile/config/http/urls.dart';
import 'package:langtech_moore_mobile/config/sharedPreferences/sharedPrefConfig.dart';
import 'package:langtech_moore_mobile/config/sharedPreferences/sharedPrefKeys.dart';
import 'package:langtech_moore_mobile/models/loginVM.dart';
import 'package:langtech_moore_mobile/models/source_donnee.dart';
import 'package:langtech_moore_mobile/models/traduction.dart';
import 'package:langtech_moore_mobile/models/user.dart';

class Http {
  static Map<String, String> headers = new Map();

  static Future<void> _getHeaders() async {
    headers = Map();
    headers.addAll({
      "Content-type": "application/json; charset=utf-8",
    });
    SharedPrefConfig.getStringData(SharePrefKeys.USER_INFOS).then((value) {
      String jwtToken = jsonDecode(value)['id_token'];
      headers.addAll({
        "Authorization": "Bearer $jwtToken",
      });
    });
  }

  static Future onAuthenticate(LoginVM loginVM) async {
    return await http.post(
      Uri.parse(Urls.LOGIN_URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(loginVM.toJson()),
    );
  }

  static Future onRegister(User user) async {
    return await http.post(Uri.parse(Urls.REGISTER_URL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(user.toJson()));
  }

  static Future<List<SourceDonnee>> getAllSourcesDonnees() async {
    String url = '${Urls.SOURCES_DATA_URL}';
    await _getHeaders();
    final response = await http
        .get(
      Uri.parse(url),
      headers: headers,
    )
        .timeout(const Duration(seconds: 5), onTimeout: () {
      return http.Response("Délai d'attente depassé !", 403);
    });
    if (response.statusCode == 200) {
      List jsonResponse =
          convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
      return jsonResponse
          .map((data) => new SourceDonnee.fromJson(data))
          .toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  static Future<List<Traduction>> getAllTraductons() async {
    String url = '${Urls.TRADUCTION_DATA_URL}';
    await _getHeaders();
    final response = await http
        .get(
      Uri.parse(url),
      headers: headers,
    )
        .timeout(const Duration(seconds: 5), onTimeout: () {
      return http.Response("Délai d'attente depassé !", 403);
    });
    if (response.statusCode == 200) {
      List jsonResponse =
          convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
      return jsonResponse.map((data) => new Traduction.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}
