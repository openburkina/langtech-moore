import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';
import 'package:langtech_moore_mobile/widgets/loginPage/app_logo.dart';
import 'package:langtech_moore_mobile/widgets/loginPage/login_form.dart';
import 'package:langtech_moore_mobile/widgets/loginPage/not_signup_section.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      return (await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => new AlertDialog(
              title: Row(
                children: [
                  Image.asset(
                    "assets/images/logo.jpg",
                    width: 75,
                    height: 75,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'LangTech',
                    style: GoogleFonts.montserrat(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: kBlue,
                    ),
                  ),
                ],
              ),
              content: Text(
                "Voulez-vous quitter l'application ?",
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'Non',
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      color: kBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => SystemNavigator.pop(),
                  child: Text(
                    'Oui',
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      color: kRed,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          )) ??
          false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: kWhite,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Container(
            color: kBlue,
          ),
        ),
        bottomNavigationBar: const NotSignupSection(),
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
      ),
    );
  }
}
