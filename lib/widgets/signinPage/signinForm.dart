import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:langtech_moore_mobile/models/user.dart';
import 'package:langtech_moore_mobile/widgets/loginPage/button_section.dart';
import 'package:langtech_moore_mobile/widgets/loginPage/input_section.dart';
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
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) {
    //     return Tabs();
    //   }),
    // );
  }
}
