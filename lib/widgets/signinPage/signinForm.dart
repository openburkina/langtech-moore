import 'dart:convert';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:langtech_moore_mobile/config/sharedPreferences/sharedPrefConfig.dart';
import 'package:langtech_moore_mobile/config/sharedPreferences/sharedPrefKeys.dart';
import 'package:langtech_moore_mobile/models/loginVM.dart';
import 'package:langtech_moore_mobile/models/user.dart';
import 'package:langtech_moore_mobile/services/http.dart';
import 'package:langtech_moore_mobile/widgets/loginPage/button_section.dart';
import 'package:langtech_moore_mobile/widgets/loginPage/input_section.dart';
import 'package:langtech_moore_mobile/widgets/shared/loadingSpinner.dart';
import 'package:langtech_moore_mobile/widgets/shared/tabs.dart';
import 'package:langtech_moore_mobile/widgets/shared/toast.dart';

class SigninForm extends StatefulWidget {
  final int delayDuration;
  const SigninForm({super.key, required this.delayDuration});

  @override
  _SigninForm createState() => _SigninForm(delayDuration);
}

class _SigninForm extends State<SigninForm> {
  final int delayDuration;
  final emailController = TextEditingController();
  final pwdController = TextEditingController();
  final confirmPwdController = TextEditingController();
  late User user = new User();
  late bool isEnaableSpinner = false;

  _SigninForm(this.delayDuration);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DelayedDisplay(
          delay: Duration(milliseconds: delayDuration * 3),
          child: InputSection(
            icon: Icons.mail_outline,
            hint: 'Entrez votre email',
            obscureText: false,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        DelayedDisplay(
          delay: Duration(milliseconds: delayDuration * 4),
          child: InputSection(
            icon: Icons.lock_outline,
            hint: 'Entrez votre mot de passe',
            obscureText: true,
            controller: pwdController,
            keyboardType: TextInputType.text,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        DelayedDisplay(
          delay: Duration(milliseconds: delayDuration * 5),
          child: InputSection(
            icon: Icons.lock_outline,
            hint: 'Confirmez le mot de passe',
            obscureText: true,
            controller: confirmPwdController,
            keyboardType: TextInputType.text,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        DelayedDisplay(
          delay: Duration(milliseconds: delayDuration * 6),
          child: ButtonSection(
            buttonText: "S'inscrire",
            buttonFonction: () => _onCheckFormValidate(context),
          ),
        ),
        isEnaableSpinner ? LoadingSpinner() : Center(),
      ],
    );
  }

  void _onCheckFormValidate(BuildContext context) {
    String email = emailController.text.trim().toLowerCase();
    String password = pwdController.text.trim().toLowerCase();
    String confirmPassword = confirmPwdController.text.trim().toLowerCase();
    if (email == '') {
      Toast.showFlutterToast(context, "L'email est obligatoire !", 'error');
    } else if (password == '') {
      Toast.showFlutterToast(
          context, "Le mot de passe est obligatoire !", 'error');
    } else if (confirmPassword == '') {
      Toast.showFlutterToast(context,
          "La confirmation du mot de passe est obligatoire !", 'error');
    } else if (confirmPassword != password) {
      Toast.showFlutterToast(
          context, "La confirmation du mot de passe est incorrecte !", 'error');
    } else {
      user.email = email;
      user.login = email;
      user.password = password;
      user.typeUtilisateur = 'CONTRIBUTEUR';
      _onSignIn(context);
    }
  }

  void _onSignIn(BuildContext context) {
    setState(() {
      isEnaableSpinner = true;
    });
    try {
      Http.onRegister(user).then((response) {
        print(response.body);
        print(response.statusCode);
        if (response.statusCode == 201) {
          Toast.showFlutterToast(
              context,
              "Félicitations! Votre inscription a été effectué avec succès !",
              'success');

          _login(context);
        } else {
          Toast.showFlutterToast(context,
              "Une erreur est survenue lors de la connexion !", 'error');
          setState(() {
            isEnaableSpinner = false;
          });
        }
      });
    } catch (exception) {
      print(exception);
      Toast.showFlutterToast(
          context, "Une erreur est survenue lors de la connexion !", 'error');
    }
  }

  void _login(BuildContext context) {
    setState(() {
      isEnaableSpinner = true;
    });
    LoginVM loginVM = new LoginVM();
    loginVM.username = user.login;
    loginVM.password = user.password;
    loginVM.rememberMe = true;
    try {
      Http.onAuthenticate(loginVM).then((response) {
        print(response.body);
        if (response.statusCode == 200) {
          _saveToken(context, jsonDecode(response.body)['id_token']);
        } else if (response.statusCode == 401) {
          Toast.showFlutterToast(
              context, jsonDecode(response.body)['detail'], 'error');
          setState(() {
            isEnaableSpinner = false;
          });
        } else {
          Toast.showFlutterToast(context,
              "Une erreur est survenue lors de la connexion !", 'error');
          setState(() {
            isEnaableSpinner = false;
          });
        }
      });
    } catch (exception) {
      print(exception);
      Toast.showFlutterToast(
          context, "Une erreur est survenue lors de la connexion !", 'error');
    }
  }

  void _saveToken(BuildContext context, String token) {
    SharedPrefConfig.saveStringData(SharePrefKeys.JWT_TOKEN, token)
        .then((value) {
      if (value) {
        Toast.showFlutterToast(context, 'Bienvenue !', 'success');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return Tabs();
          }),
        );
      } else {
        Toast.showFlutterToast(
            context, "Une erreur est survenue lors de la connexion !", 'error');
      }

      setState(() {
        isEnaableSpinner = false;
      });
    });
  }
}
