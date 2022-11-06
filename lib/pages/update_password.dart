import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';
import 'package:langtech_moore_mobile/models/password.dart';
import 'package:langtech_moore_mobile/services/http.dart';
import 'package:langtech_moore_mobile/widgets/loginPage/button_section.dart';
import 'package:langtech_moore_mobile/widgets/loginPage/input_section.dart';
import 'package:langtech_moore_mobile/widgets/shared/loadingSpinner.dart';
import 'package:langtech_moore_mobile/widgets/shared/toast.dart';
import 'dart:developer';

class UpdatePassword extends StatefulWidget {
  UpdatePassword({Key? key}) : super(key: key);

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  int delayDuration = 25;

  bool isEnaableSpinner = false;

  Password password = new Password();

  final currentPwdCtrl = TextEditingController();

  final newPwdCtrl = TextEditingController();

  final confirmPwdCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kBlue,
        elevation: 0,
        title: Text(
          'Modifier mon mot de passe',
          style: GoogleFonts.montserrat(
            fontSize: 20,
            color: kWhite,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: !isEnaableSpinner ? ButtonSection(
          buttonFonction: _getPasswordInfos,
          buttonText: "Enregistrer",
          buttonSize: 20,
        ) : SizedBox(),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            DelayedDisplay(
              delay: Duration(milliseconds: delayDuration * 3),
              child: InputSection(
                icon: Icons.lock_outline,
                hint: 'Entrez votre mot de passe actuel',
                obscureText: true,
                controller: currentPwdCtrl,
                keyboardType: TextInputType.text
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            DelayedDisplay(
              delay: Duration(milliseconds: delayDuration * 4),
              child: InputSection(
                icon: Icons.lock_outline,
                hint: 'Entrez le nouveau mot de passe',
                obscureText: true,
                controller: newPwdCtrl,
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            DelayedDisplay(
              delay: Duration(milliseconds: delayDuration * 5),
              child: InputSection(
                icon: Icons.lock_outline,
                hint: 'Confirmez le nouveau mot de passe',
                obscureText: true,
                controller: confirmPwdCtrl,
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            isEnaableSpinner ? LoadingSpinner() : Center(),
          ],
        ),
      ),
    );
  }

  void _getPasswordInfos() {
    String currentPassword = currentPwdCtrl.text.trim();
    String newPassword = newPwdCtrl.text.trim();
    String confirmPassword = confirmPwdCtrl.text.trim();
    if (currentPassword == '') {
      Toast.showFlutterToast(context, "L'ancien mot de passe est obligatoire !", "warning");
    } else if (newPassword == '') {
      Toast.showFlutterToast(context, "Le nouveau mot de passe est obligatoire !", "warning");
    } else if (confirmPassword == '') {
      Toast.showFlutterToast(context, "La confirmation du nouveau mot de passe est obligatoire !", "warning");
    } else if (newPassword.length < 4) {
      Toast.showFlutterToast(context, "Le nouveau mot de passe doit avoir au moins 4 caractères !", "warning");
    } else if (newPassword != confirmPassword) {
      Toast.showFlutterToast(context, "La confirmation du nouveau mot de passe est incorrect !", "warning");
    } else {
      password.currentPassword = currentPassword;
      password.newPassword = newPassword;
      _onUpdatePassword();
    }
  }

  void _onUpdatePassword() {
    setState(() {
      isEnaableSpinner = true;
    });
    Http.onUpdatePassword(password).then((response) {
      setState(() {
        isEnaableSpinner = false;
      });
      if (response.statusCode == 200) {
        Toast.showFlutterToast(context, "Votre mot de passe a été modifié avec succès !", "success");
        Navigator.pop(context);
      } else {
        Toast.showFlutterToast(context, "Une erreur est survenue lors de la modification de votre mot de passe", "error");
      }
    });
  }
}
