import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';
import 'package:langtech_moore_mobile/widgets/apropos/AproposInfos.dart';

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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo.jpg",
              width: 200,
              height: 200,
            ),
            Text(
              'LangTech',
              style: GoogleFonts.montserrat(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: kBlue,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              'v1.0.0',
              style: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: kBlue,
              ),
            ),
            AProposInfos(),
          ],
        ),
      ),
    );
  }
}
