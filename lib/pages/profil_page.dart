import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langtech_moore_mobile/config/sharedPreferences/sharedPrefConfig.dart';
import 'package:langtech_moore_mobile/config/sharedPreferences/sharedPrefKeys.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';
import 'package:langtech_moore_mobile/models/utilisateur.dart';
import 'package:langtech_moore_mobile/pages/a_propos.dart';
import 'package:langtech_moore_mobile/pages/update_password.dart';
import 'package:langtech_moore_mobile/pages/update_profil.dart';
import 'package:langtech_moore_mobile/widgets/profilPage/parameter.dart';

import 'package:share_plus/share_plus.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  late Utilisateur currentUser = new Utilisateur();

  void _getCurrentUserInfos() {
    SharedPrefConfig.getStringData(SharePrefKeys.USER_INFOS).then((value) {
      setState(() {
        currentUser = Utilisateur.fromJson(jsonDecode(value)['utilisateur']);
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
      backgroundColor: kGris,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(2),
        child: Container(
          color: kBlue,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
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
                        // border: Border.all(width: 5, color: kRed),
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Center(
                              child: Icon(
                                FontAwesomeIcons.userTie,
                                size: 75,
                                color: kBlue,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: FloatingActionButton(
                              heroTag: null,
                              mini: true,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return UpdateProfil(
                                        currentUser: currentUser,
                                      );
                                    },
                                  ),
                                ).then(
                                  (response) {
                                    if (response == true) {
                                      setState(() {
                                        _getCurrentUserInfos();
                                      });
                                    }
                                  },
                                );
                              },
                              backgroundColor: kRed,
                              elevation: 0,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.padded,
                              child: const Icon(
                                FontAwesomeIcons.pencil,
                                size: 25.0,
                              ),
                            ),
                          ),
                        ],
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
                          Text(
                            '${currentUser.telephone}',
                            style: TextStyle(
                              color: kWhite,
                              fontSize: 16,
                            ),
                          ),
                          currentUser.email != '' && currentUser.email != null
                              ? Text(
                                  '  |  ${currentUser.email}',
                                  style: TextStyle(
                                    color: kWhite,
                                    fontSize: 16,
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              pointFideliteSection(),
              Container(
                color: kGris,
                child: Column(
                  children: [
                    // Parameter(
                    //   icon: Icons.person,
                    //   title: 'Mon Profil',
                    //   subTitle: 'Modifier mon profil',
                    //   function: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) {
                    //           return UpdateProfil(
                    //             currentUser: currentUser,
                    //           );
                    //         },
                    //       ),
                    //     ).then(
                    //       (response) {
                    //         if (response == true) {
                    //           setState(() {
                    //             _getCurrentUserInfos();
                    //           });
                    //         }
                    //       },
                    //     );
                    //   },
                    // ),
                    Parameter(
                      icon: Icons.lock,
                      title: 'Mon Mot de passe',
                      subTitle: 'Modifier mon mot de passe',
                      function: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return UpdatePassword();
                            },
                          ),
                        );
                      },
                    ),
                    Parameter(
                      icon: Icons.share,
                      title: 'Partager l\'application',
                      subTitle: 'Partager avec mes amis',
                      function: () {
                        Share.share('https://www.openburkina.bf/');
                      },
                    ),
                    Parameter(
                      icon: Icons.info,
                      title: 'A propos',
                      subTitle: 'A propos de l\'application',
                      function: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return APropos();
                            },
                          ),
                        );
                      },
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

  Container pointFideliteSection() {
    return Container(
      color: kWhite,
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Point de fidélité',
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: kBlue,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: kRed,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              "${currentUser.pointFidelite}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: kWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
