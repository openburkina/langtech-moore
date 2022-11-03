import 'dart:convert';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:langtech_moore_mobile/config/http/urls.dart';
import 'package:langtech_moore_mobile/config/sharedPreferences/sharedPrefConfig.dart';
import 'package:langtech_moore_mobile/config/sharedPreferences/sharedPrefKeys.dart';
import 'package:langtech_moore_mobile/models/langue.dart';
import 'package:langtech_moore_mobile/models/loginVM.dart';
import 'package:langtech_moore_mobile/models/source_donnee.dart';
import 'package:langtech_moore_mobile/models/traduction.dart';
import 'package:langtech_moore_mobile/models/user.dart';

class Http {
  static Map<String, String> headers = new Map();
  static User currentUser = new User();

  static Future<void> _getHeaders() async {
    headers = Map();
    headers.addAll({
      "Content-type": "application/json; charset=utf-8",
    });
    SharedPrefConfig.getStringData(SharePrefKeys.USER_INFOS).then((value) {
      // Get current user token
      String jwtToken = jsonDecode(value)['id_token'];
      headers.addAll({
        "Authorization": "Bearer $jwtToken",
      });

      // Get current user instance
      currentUser = User.fromJson(jsonDecode(value)['utilisateur']);
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

  static Future<List<Traduction>> getAllTraductons({
    int size = 10,
    int page = 0,
  }) async {
    String url = '${Urls.GET_ALL_TRADUCTIONS}?page=${page}&size=${size}';
    await _getHeaders();
    Traduction traduction = new Traduction();
    traduction.utilisateur = currentUser;
    final response = await http
        .post(
      Uri.parse(url),
      body: jsonEncode(traduction.toJson()),
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

  static Future onSaveTraduction(Traduction traduction) async {
    await _getHeaders();
    traduction.utilisateur = currentUser;
    return await http
        .post(
      Uri.parse(Urls.DEFAULT_TRADUCTION_URL),
      headers: headers,
      body: json.encode(
        traduction.toJson(),
      ),
    )
        .timeout(const Duration(seconds: 5), onTimeout: () {
      return http.Response("Délai d'attente depassé !", 403);
    });
  }

  static Future onDeleteTraduction(int traductionId) async {
    String url = "${Urls.DEFAULT_TRADUCTION_URL}/$traductionId";
    await _getHeaders();
    return await http
        .delete(
      Uri.parse(url),
      headers: headers,
    )
        .timeout(const Duration(seconds: 5), onTimeout: () {
      return http.Response("Délai d'attente depassé !", 403);
    });
  }

  static Future<List<Langue>> getLangues() async {
    String url = '${Urls.LANGUES}';
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
          .map(
            (data) => Langue.fromJson(data),
          )
          .toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}
