import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:langtech_moore_mobile/config/sharedPreferences/sharedPrefConfig.dart';
import 'package:langtech_moore_mobile/config/sharedPreferences/sharedPrefKeys.dart';
import 'package:langtech_moore_mobile/models/loginVM.dart';
import 'package:langtech_moore_mobile/services/http.dart';
import 'package:langtech_moore_mobile/widgets/loginPage/button_section.dart';
import 'package:langtech_moore_mobile/widgets/loginPage/input_section.dart';
import 'package:langtech_moore_mobile/widgets/loginPage/not_signup_section.dart';
import 'package:langtech_moore_mobile/widgets/shared/loadingSpinner.dart';
import 'package:langtech_moore_mobile/widgets/shared/phone_input_section.dart';
import 'package:langtech_moore_mobile/widgets/shared/slidepage.dart';
import 'package:langtech_moore_mobile/widgets/shared/tabs.dart';
import 'package:langtech_moore_mobile/widgets/shared/toast.dart';

class LoginForm extends StatefulWidget {
  final int delayDuration;

  const LoginForm({super.key, required this.delayDuration});
  @override
  _LoginFormState createState() => _LoginFormState(delayDuration);
}

class _LoginFormState extends State<LoginForm> {
  final int delayDuration;
  final phoneIndicatifController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final pwdController = TextEditingController();
  late bool isEnaableSpinner = false;
  final _formKey = GlobalKey<FormState>();
  late LoginVM loginVM = new LoginVM();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'BF';
  PhoneNumber number = PhoneNumber(isoCode: 'BF');

  _LoginFormState(this.delayDuration);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          DelayedDisplay(
            delay: Duration(milliseconds: delayDuration * 3),
            child: PhoneInputSection(
              icon: Icons.add,
              hint: 'Numéro de téléphone',
              phoneIndicatifController: phoneIndicatifController,
              phoneNumberController: phoneNumberController,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          DelayedDisplay(
            delay: Duration(milliseconds: delayDuration * 4),
            child: InputSection(
              icon: Icons.lock_outline,
              hint: 'Mot de passe',
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
            child: ButtonSection(
              buttonText: 'Se connecter',
              buttonFonction: () => _onValidateForm(context),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          DelayedDisplay(
            delay: Duration(milliseconds: delayDuration * 6),
            child: const NotSignupSection(),
          ),
          isEnaableSpinner ? LoadingSpinner() : Center(),
        ],
      ),
    );
  }

  void _onValidateForm(BuildContext context) {
    loginVM.username = phoneIndicatifController.text.replaceAll('+', '') +
        phoneNumberController.text.trim();
    loginVM.password = pwdController.text.trim();
    if (loginVM.username == null || loginVM.username == '') {
      Toast.showFlutterToast(
        context,
        "Le numéro de téléphone est obligatoire !",
        'error',
      );
    } else if (loginVM.password == null || loginVM.password == '') {
      Toast.showFlutterToast(
        context,
        "Le mot de passe est obligatoire !",
        'error',
      );
    } else {
      _login(context);
    }
  }

  void _login(BuildContext context) {
    setState(() {
      isEnaableSpinner = true;
    });
    print(loginVM.toJson());
    try {
      Http.onAuthenticate(loginVM).then((response) {
        print(response.body);
        if (response.statusCode == 200) {
          _saveUserInfos(context, response.body);
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
    }
  }

  void _saveUserInfos(BuildContext context, String userInfos) {
    SharedPrefConfig.saveStringData(SharePrefKeys.USER_INFOS, userInfos)
        .then((value) async {
      if (value) {
        await SharedPrefConfig.saveBoolData(SharePrefKeys.IS_REGISTERED, true);
        Toast.showFlutterToast(context, 'Bienvenue !', 'success');
        Navigator.of(context).pushReplacement(
          SlideRightRoute(
            child: const Tabs(),
            page: const Tabs(),
            direction: AxisDirection.left,
          ),
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
