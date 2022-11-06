import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';

class APropos extends StatelessWidget {
  const APropos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kBlue,
        elevation: 0,
        title: Text(
          'A propos !',
          style: GoogleFonts.montserrat(
            fontSize: 20,
            color: kWhite,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
