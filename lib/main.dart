import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:langtech_moore_mobile/bloc/forgot_password.bloc.dart';
import 'package:langtech_moore_mobile/bloc/loading_spinner.bloc.dart';
import 'package:langtech_moore_mobile/bloc/user/user.bloc.dart';
import 'package:langtech_moore_mobile/config/sharedPreferences/sharedPrefConfig.dart';
import 'package:langtech_moore_mobile/config/sharedPreferences/sharedPrefKeys.dart';
import 'package:langtech_moore_mobile/pages/login_page.dart';
import 'package:langtech_moore_mobile/pages/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool registeredStatus =
      await SharedPrefConfig.getBoolData(SharePrefKeys.IS_REGISTERED);
  runApp(
    MyApp(
      isRegistered: registeredStatus,
    ),
  );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  bool isRegistered;
  MyApp({
    super.key,
    required this.isRegistered,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoadingSpinnerBloc(),
        ),
        BlocProvider(
          create: (context) => PasswordResetBloc(),
        ),
        BlocProvider(
          create: (context) => UserBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'LangTech Moore App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: isRegistered ? LoginPage() : SplashScreen(),
      ),
    );
  }
}
