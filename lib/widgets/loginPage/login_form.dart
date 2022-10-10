import 'package:flutter/material.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:langtech_moore_mobile/models/loginVM.dart';
import 'package:langtech_moore_mobile/services/http.dart';
import 'package:langtech_moore_mobile/widgets/loginPage/button_section.dart';
import 'package:langtech_moore_mobile/widgets/loginPage/input_section.dart';
import 'package:langtech_moore_mobile/widgets/loginPage/not_signup_section.dart';
import 'package:langtech_moore_mobile/widgets/shared/tabs.dart';

class LoginForm extends StatelessWidget {
  final int delayDuration;
  LoginForm({super.key, required this.delayDuration});
  final emailController = TextEditingController();
  final pwdController = TextEditingController();

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
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        DelayedDisplay(
          delay: Duration(milliseconds: delayDuration * 5),
          child: ButtonSection(
            buttonText: 'Se connecter',
            buttonFonction: () => _login(context),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        DelayedDisplay(
          delay: Duration(milliseconds: delayDuration * 6),
          child: const NotSignupSection(),
        ),
      ],
    );
  }

  void _login(BuildContext context) {
    LoginVM loginVM = new LoginVM();
    loginVM.username = emailController.text.trim().toLowerCase();
    loginVM.password = pwdController.text.trim().toLowerCase();
    print(loginVM.toJson());
    // try {
    //   Http.onAuthenticate(loginVM).then((response) {
    //     print(response.body);
    //   });
    // } catch (exception) {
    //   print(exception);
    // }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return Tabs();
      }),
    );
  }
}
