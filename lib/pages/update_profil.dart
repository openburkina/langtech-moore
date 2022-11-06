import 'dart:convert';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langtech_moore_mobile/config/sharedPreferences/sharedPrefConfig.dart';
import 'package:langtech_moore_mobile/config/sharedPreferences/sharedPrefKeys.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';
import 'package:langtech_moore_mobile/models/user.dart';
import 'package:langtech_moore_mobile/services/http.dart';
import 'package:langtech_moore_mobile/widgets/loginPage/button_section.dart';
import 'package:langtech_moore_mobile/widgets/loginPage/input_section.dart';
import 'package:langtech_moore_mobile/widgets/shared/loadingSpinner.dart';
import 'dart:developer';
import 'dart:convert' as convert;

import 'package:langtech_moore_mobile/widgets/shared/toast.dart';

class UpdateProfil extends StatefulWidget {
  final User currentUser;
  const UpdateProfil({Key? key, required this.currentUser}) : super(key: key);

  @override
  State<UpdateProfil> createState() => _UpdateProfilState();
}

class _UpdateProfilState extends State<UpdateProfil> {
  int delayDuration = 25;
  bool isEnaableSpinner = false;
  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final phoneController = TextEditingController();
  User user = new User();

  void _initForm() {
    nomController.text = "${widget.currentUser.nom}";
    prenomController.text = "${widget.currentUser.prenom}";
    phoneController.text = "${widget.currentUser.telephone}";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initForm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kBlue,
        elevation: 0,
        title: Text(
          'Modifier mon profil',
          style: GoogleFonts.montserrat(
            fontSize: 20,
            color: kWhite,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: !isEnaableSpinner ? ButtonSection(
          buttonFonction: _getProfilInfos,
          buttonText: "Enregistrer",
          buttonSize: 20,
        ) : SizedBox(),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            DelayedDisplay(
              delay: Duration(milliseconds: delayDuration * 3),
              child: InputSection(
                icon: Icons.person,
                hint: 'Entrez votre nom',
                obscureText: false,
                controller: nomController,
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            DelayedDisplay(
              delay: Duration(milliseconds: delayDuration * 4),
              child: InputSection(
                icon: Icons.person,
                hint: 'Entrez votre prénom(s)',
                obscureText: false,
                controller: prenomController,
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            DelayedDisplay(
              delay: Duration(milliseconds: delayDuration * 5),
              child: InputSection(
                icon: Icons.phone,
                hint: 'Entrez votre téléphone (+226XXXX)',
                obscureText: false,
                controller: phoneController,
                keyboardType: TextInputType.phone,
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            isEnaableSpinner ? LoadingSpinner() : Center(),
          ],
        ),
      ),
    );
  }

  void _getProfilInfos() {
    user.id = widget.currentUser.id;
    user.nom = nomController.text.trim().toUpperCase();
    user.prenom = prenomController.text.trim();
    user.telephone = phoneController.text.trim();
    user.typeUtilisateur = widget.currentUser.typeUtilisateur;
    user.pointFidelite = widget.currentUser.pointFidelite;
    user.email = widget.currentUser.email;
    if (user.nom == '') {
      Toast.showFlutterToast(context, "Veuillez entrer votre nom !", 'warning');
    } else if (user.prenom == '') {
      Toast.showFlutterToast(context, "Veuillez entrer votre prénom !", 'warning');
    } else if (user.telephone == '') {
      Toast.showFlutterToast(context, "Veuillez entrer votre numéro de téléphone !", 'warning');
    } else {
      _updateProfil();
    }
  }

  void _updateProfil() {
    setState(() {
      isEnaableSpinner = true;
    });
    Http.onUpdateProfil(user).then((response) {
      setState(() {
        isEnaableSpinner = false;
      });
      if (response.statusCode == 200) {
        Toast.showFlutterToast(context, "Votre profil a été modifié avec succès !", "success");
        _saveUpdateUserInfos(response.body);
        // Navigator.pop(context, );
      } else {
        Toast.showFlutterToast(context, "Une erreur est survenue lors de la modification de votre profil", "error");
      }
    });
  }

  void _saveUpdateUserInfos(String updateUser) async {
    String currentUserInfos = await SharedPrefConfig.getStringData(SharePrefKeys.USER_INFOS);
    String jwtToken = jsonDecode(currentUserInfos)['id_token'];
    Map<String, dynamic> updateUserInfos = {
      "\"utilisateur\"": updateUser,
      "\"id_token\"": "\"${jwtToken}\"",
    };
    bool savedResponse = await SharedPrefConfig.saveStringData(SharePrefKeys.USER_INFOS, "${updateUserInfos}");
    if (savedResponse) {
      Navigator.pop(context, true);
    }
  }
}
