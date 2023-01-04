import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';
import 'package:langtech_moore_mobile/widgets/loginPage/app_logo.dart';
import 'package:langtech_moore_mobile/widgets/signinPage/signinForm.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kBlue,
        elevation: 0,
        title: Text(
          'Inscription',
          style: GoogleFonts.montserrat(
            fontSize: 24,
            color: kWhite,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            AppLogo(),
            SizedBox(
              height: 10,
            ),
            SigninForm(
              delayDuration: 50,
            ),
          ],
        ),
      )),
    );
  }
}
