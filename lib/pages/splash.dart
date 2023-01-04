import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:langtech_moore_mobile/pages/login_page.dart';

import '../constants/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  State<SplashScreen> createState() => _ScreenPageState();
}

class _ScreenPageState extends State<SplashScreen> {
  final List<PageViewModel> pages = [
    PageViewModel(
      title: "Qui utilise l'intelligence artificielle ?",
      body:
          "De nos jours, aucun secteur d'activité n'est épargné par la montée en puissance de l'intelligence artificielle. \n\n Et pour cause, les algorithmes de machine learning se déclinent à tous les étages en fonction des problématiques business",
      image: Center(
        child: Image.asset("assets/images/slide/slide3.png"),
      ),
      decoration: pageDecoration(),
    ),
    PageViewModel(
      title: "Comment entraîner une intelligence artificielle ?",
      body:
          "Les données sont au cœur de la technologie de l'IA.\n\nL’intelligence humaine, l’IA a d’abord besoin d’apprendre pour se développer et réaliser son plein potentiel à travers ces données",
      image: Center(
        child: Image.asset("assets/images/slide/slide1.png"),
      ),
      decoration: pageDecoration(),
    ),
    PageViewModel(
      title: "Bonus pour les contributeurs ?",
      body:
          "Il s’agit d’un bon plan pour ceux qui prennent le temps d’alimenter la plateforme avec leurs contributions en fournissant la traduction des données sources",
      image: Center(
        child: Image.asset("assets/images/slide/slide2.png"),
      ),
      decoration: pageDecoration(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Container(
            color: kBlue,
          ),
        ),
        body: IntroductionScreen(
          pages: pages,
          dotsDecorator: const DotsDecorator(
            size: Size(15, 15),
            color: kBlue,
            activeSize: Size.square(15),
            activeColor: kRed,
          ),
          showDoneButton: true,
          done: Text(
            "Lancer",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: kBlue,
            ),
          ),
          showNextButton: true,
          next: Text(
            "Suivant",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: kBlue,
            ),
          ),
          showSkipButton: true,
          skip: Text(
            "Ignorer",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: kRed,
            ),
          ),
          onDone: () => done(context),
          onSkip: () => done(context),
        ));
  }

  void done(context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}

PageDecoration pageDecoration() {
  return PageDecoration(
    footerPadding: const EdgeInsets.all(0),
    titleTextStyle: GoogleFonts.montserrat(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: kBlue,
    ),
    bodyTextStyle: GoogleFonts.montserrat(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
    ),
    imagePadding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
  );
}
