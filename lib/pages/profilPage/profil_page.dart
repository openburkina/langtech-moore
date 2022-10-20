import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langtech_moore_mobile/config/sharedPreferences/sharedPrefConfig.dart';
import 'package:langtech_moore_mobile/config/sharedPreferences/sharedPrefKeys.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';
import 'package:langtech_moore_mobile/models/user.dart';
import 'package:langtech_moore_mobile/pages/loginPage/login_page.dart';
import 'package:langtech_moore_mobile/widgets/profilPage/parameter.dart';
import 'package:langtech_moore_mobile/widgets/shared/slidepage.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  late User currentUser = new User();

  void _getCurrentUserInfos() {
    SharedPrefConfig.getStringData(SharePrefKeys.USER_INFOS).then((value) {
      setState(() {
        currentUser = User.fromJson(jsonDecode(value)['utilisateur']);
      });
    });
  }

  void _onLogout() async {
    await showDialog(
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
          "Voulez-vous vous déconnecter de l'application ?",
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
            onPressed: () => Navigator.of(context).pushReplacement(
              SlideRightRoute(
                child: const LoginPage(),
                page: const LoginPage(),
                direction: AxisDirection.left,
              ),
            ),
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
    );
  }

  @override
  void initState() {
    super.initState();
    _getCurrentUserInfos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlue,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [kBlue, kBlue],
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 5, color: kRed),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Icon(
                          Icons.person,
                          size: 75,
                          color: kBlue,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          currentUser.prenom != ''
                              ? Text(
                                  '${currentUser.prenom}',
                                  style: TextStyle(
                                    color: kWhite,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : Center(),
                          const SizedBox(
                            width: 5,
                          ),
                          currentUser.nom != ''
                              ? Text(
                                  '${currentUser.nom}',
                                  style: TextStyle(
                                    color: kWhite,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : Center(),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          currentUser.email != ''
                              ? Text(
                                  '${currentUser.email}',
                                  style: TextStyle(
                                    color: kWhite,
                                    fontSize: 18,
                                  ),
                                )
                              : Center(),
                          currentUser.telephone != ''
                              ? Text(
                                  '  |  ${currentUser.telephone}',
                                  style: TextStyle(
                                    color: kWhite,
                                    fontSize: 18,
                                  ),
                                )
                              : Center(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              postFollowSection,
              Container(
                color: kGris,
                child: Column(
                  children: [
                    Parameter(
                      icon: Icons.person,
                      title: 'Mon Profil',
                      subTitle: 'Modifier mon profil',
                      function: () {},
                    ),
                    Parameter(
                      icon: Icons.lock,
                      title: 'Mon Mot de passe',
                      subTitle: 'Modifier mon mot de passe',
                      function: () {},
                    ),
                    Parameter(
                      icon: Icons.share,
                      title: 'Partager l\'application',
                      subTitle: 'Partager avec mes amis',
                      function: () {},
                    ),
                    Parameter(
                      icon: Icons.info,
                      title: 'A propos',
                      subTitle: 'A propos de l\'application',
                      function: () {},
                    ),
                    Parameter(
                      icon: Icons.logout,
                      title: 'Déconnexion',
                      subTitle: 'Se déconnecter de l\'application',
                      function: _onLogout,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget postFollowSection = Container(
  color: kWhite,
  padding: const EdgeInsets.symmetric(vertical: 20),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      contributionSection,
      pointFideliteSection,
    ],
  ),
);

Widget contributionSection = Column(
  children: const [
    Text(
      'Contributions',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: kBlue,
      ),
    ),
    Text(
      '12',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: kRed,
      ),
    )
  ],
);

Widget pointFideliteSection = Column(
  children: const [
    Text(
      'Point de fidélité',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: kBlue,
      ),
    ),
    Text(
      '10',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: kRed,
      ),
    )
  ],
);
