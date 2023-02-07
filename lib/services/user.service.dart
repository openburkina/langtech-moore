import 'dart:convert';

import 'package:langtech_moore_mobile/config/sharedPreferences/sharedPrefConfig.dart';
import 'package:langtech_moore_mobile/config/sharedPreferences/sharedPrefKeys.dart';
import 'package:langtech_moore_mobile/models/utilisateur.dart';

class UserService {
  static Future<Utilisateur> getCurrentUserInfos() async {
    String currentUser =
        await SharedPrefConfig.getStringData(SharePrefKeys.USER_INFOS);
    return Utilisateur.fromJson(jsonDecode(currentUser)['utilisateur']);
  }
}
