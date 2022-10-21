import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';

class ButtonSection extends StatelessWidget {
  final String buttonText;
  final VoidCallback buttonFonction;
  final Color buttonColor;
  const ButtonSection({
    super.key,
    required this.buttonText,
    required this.buttonFonction,
    this.buttonColor = kBlue,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: buttonColor,
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: buttonFonction,
      child: Text(
        buttonText,
        style: GoogleFonts.montserrat(
          fontSize: 24,
          color: kWhite,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
