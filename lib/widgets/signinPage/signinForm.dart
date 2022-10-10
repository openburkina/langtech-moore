import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:langtech_moore_mobile/widgets/loginPage/button_section.dart';
import 'package:langtech_moore_mobile/widgets/loginPage/input_section.dart';

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
          child: InputSection(
            icon: Icons.lock_outline,
            hint: 'Confirmez le mot de passe',
            obscureText: true,
            controller: pwdController,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        DelayedDisplay(
          delay: Duration(milliseconds: delayDuration * 6),
          child: ButtonSection(
            buttonText: "S'inscrire",
            buttonFonction: () => _login(context),
          ),
        ),
      ],
    );
  }

  void _login(BuildContext context) {
    print(
        "loginPage => loginForm => login => emailController => ${emailController.text}");
    print(
        "loginPage => loginForm => login => pwdController => ${pwdController.text}");
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) {
    //     return Tabs();
    //   }),
    // );
  }
}
