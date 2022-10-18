

import 'package:flutter/material.dart';
import 'package:langtech_moore_mobile/config/sharedPreferences/sharedPrefConfig.dart';
import 'package:langtech_moore_mobile/config/sharedPreferences/sharedPrefKeys.dart';
import 'package:langtech_moore_mobile/pages/loginPage/login_page.dart';
import 'package:langtech_moore_mobile/pages/slidePage/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool registeredStatus =  await SharedPrefConfig.getBoolData(SharePrefKeys.IS_REGISTERED);
  runApp(MyApp(isRegistered: registeredStatus,));
}

class MyApp extends StatelessWidget {
  bool isRegistered;
  MyApp({super.key, required this.isRegistered,});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LangTech Moore App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isRegistered ? LoginPage() : SplashScreen(),
    );
  }
}
