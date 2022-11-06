import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';
import 'package:langtech_moore_mobile/widgets/loginPage/button_section.dart';

class UpdatePassword extends StatelessWidget {
  const UpdatePassword({Key? key}) : super(key: key);

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
        child: ButtonSection(
          buttonFonction: _getPasswordInfos,
          buttonText: "Enregistrer",
          buttonSize: 20,
        ),
      ),
    );
  }

  void _getPasswordInfos() {}
}
