import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';
import 'package:langtech_moore_mobile/widgets/loginPage/app_logo.dart';
import 'package:langtech_moore_mobile/widgets/loginPage/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            AppLogo(),
            SizedBox(
              height: 20,
            ),
            Text(
              'Connexion',
              style: GoogleFonts.montserrat(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: kBlue,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            LoginForm(
              delayDuration: 100,
            ),
          ],
        ),
      )),
    );
  }
}
