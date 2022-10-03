
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:langtech_moore_mobile/pages/loginPage/login_page.dart';

import '../../constants/colors.dart';

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
        footer: ElevatedButton(
            onPressed: () => {}, child: const Text("Commencez!")),
        image: Center(child: Image.asset("images/ia1.webp")),
        decoration: const PageDecoration(
            titleTextStyle:
                TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
    PageViewModel(
        title: "Comment entraîner une intelligence artificielle ?",
        body: "Les données sont au cœur de la technologie de l'IA.\n\nL’intelligence humaine, l’IA a d’abord besoin d’apprendre pour se développer et réaliser son plein potentiel à travers ces données",
        footer: ElevatedButton(
            onPressed: () => {}, child: const Text("Commencer!")),
        image: Center(child: Image.asset("images/ia2.jpg")),
        decoration: const PageDecoration(
            titleTextStyle:
                TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
    PageViewModel(
        title: "Bonus pour les contributeurs ?",
        body: "Il s’agit d’un bon plan pour ceux qui prennent le temps d’alimenter la plateforme avec leurs contributions en fournissant la traduction des données sources",
        footer: ElevatedButton(
            onPressed: () => {}, child: const Text("Commencer!")),
        image: Center(child: Image.asset("images/ia3.webp")),
        decoration: const PageDecoration(
            titleTextStyle:
            TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IntroductionScreen(
      pages: pages,
      dotsDecorator: const DotsDecorator(
          size: Size(15, 15),
          color: kBlue,
          activeSize: Size.square(15),
          activeColor: kRed),
      showDoneButton: true,
      done: const Text("Lancer"),
      showNextButton: true,
      next: const Text("Suivant"),
      showSkipButton: true,
      skip: const Text("Ignorer",style: TextStyle(fontWeight: FontWeight.bold)),
          onDone: () =>done(context),
          onSkip: () =>{},
    ));
  }
  void done(context){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}
