// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:langtech_moore_mobile/config/sharedPreferences/sharedPrefConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:langtech_moore_mobile/config/sharedPreferences/sharedPrefKeys.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoged = false;
  @override
  void initState() {
    super.initState();
    getLogedToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Login Page $isLoged'),
      ),
    );
  }

  void getLogedToken() {
    SharedPrefConfig.saveIntData(SharePrefKeys.AUTHENTICATED, 2).then((value) {
      print('loginPage => getLogedToken => => saveBoolData $value');
    });
    SharedPrefConfig.getBoolData(SharePrefKeys.AUTHENTICATED).then((value) {
      setState(() {
        isLoged = value;
        print('loginPage => getLogedToken => $isLoged');
      });
    });
  }
}
