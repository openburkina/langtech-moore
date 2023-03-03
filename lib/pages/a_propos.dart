import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';
import 'package:langtech_moore_mobile/widgets/apropos/AproposInfos.dart';

class APropos extends StatelessWidget {
  const APropos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
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
      body: SingleChildScrollView(
        child: Center(
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
              AProposInfos(
                icon: Icons.location_on,
                title: "Adresse",
                content:
                    "Avenue Charles De Gaulle, Dagnoen, Rue 29.13, Ouaga. 17 BP 85 Ouagadougou, BURKINA FASO",
              ),
              AProposInfos(
                icon: Icons.phone,
                title: "Téléphone",
                content: "+226 60 67 58 58",
              ),
              AProposInfos(
                icon: Icons.mail_outline,
                title: "Email",
                content: "contact@openburkina.bf",
              ),
              AProposInfos(
                icon: Icons.web_rounded,
                title: "Site Web",
                content: "https://www.openburkina.bf/",
              ),
              AProposInfos(
                icon: Icons.facebook_outlined,
                title: "Facebook",
                content: "fb.com/openburkina",
              ),
              AProposInfos(
                icon: FontAwesomeIcons.twitter,
                title: "Twitter",
                content: "@OpenBurkina",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
