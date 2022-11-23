import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';
import 'package:langtech_moore_mobile/models/traduction.dart';
import 'package:langtech_moore_mobile/pages/data_translate.page.dart';
import 'package:langtech_moore_mobile/services/http.dart';
import 'package:langtech_moore_mobile/widgets/detailContribution/bottom_button.dart';
import 'package:langtech_moore_mobile/widgets/detailContribution/play_audio.dart';
import 'package:langtech_moore_mobile/widgets/shared/toast.dart';
import 'package:langtech_moore_mobile/widgets/shared/traduction_infos.dart';

class DetailContribution extends StatefulWidget {
  final Traduction traduction;
  DetailContribution({
    super.key,
    required this.traduction,
  });

  @override
  State<DetailContribution> createState() => _DetailContributionState(
        traduction: traduction,
      );
}

class _DetailContributionState extends State<DetailContribution> {
  Traduction traduction;
  String createdDate = '';

  _DetailContributionState({
    required this.traduction,
  });

  @override
  void initState() {
    String createdDate = "${traduction.createdDate!.substring(0, 10)} ${traduction.createdDate!.substring(11, 19)}";
    this.createdDate = DateFormat("dd/MM/yyyy").format(DateTime.parse(createdDate)) + ' à ' + traduction.createdDate!.substring(11, 19);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGris,
      appBar: AppBar(
        backgroundColor: kBlue,
        title: Text(
          "Détail d'une contribution",
          style: GoogleFonts.montserrat(),
        ),
      ),
      bottomNavigationBar: traduction.etat == 'EN_ATTENTE'
          ? BottomButtom(
              deleteTraduction: _showDeleteConfirm,
              updateTraduction: _onNavigateToUpdate,
            )
          : SizedBox(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TraductionInfos(
              title: "Source de données",
              content: "${traduction.libelle}",
            ),
            TraductionInfos(
              title: "Type de traduction",
              content: "${traduction.type}",
            ),
            traduction.type == 'TEXTE'
                ? TraductionInfos(
                    title: "Ma traduction",
                    content: "${traduction.contenuTexte}",
                  )
                : SizedBox(),
            TraductionInfos(
              title: "Langue",
              content: "${traduction.langue!.libelle}",
            ),
            TraductionInfos(
              title: "Etat",
              content: "${getContributionStatus(traduction.etat)}",
              contentColor: getColor(traduction.etat),
            ),
            TraductionInfos(
                title: 'Date de création',
              content: '${createdDate}',
            ),
            traduction.type == 'AUDIO'
                ? PlayAudio(
                    traduction: traduction,
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  void _deleteTraduction() {
    Http.onDeleteTraduction(traduction.id!).then((response) {
      if (response.statusCode == 204) {
        Toast.showFlutterToast(
          context,
          "Votre traduction a été supprimée avec succès !",
          "success",
        );
        Navigator.pop(context, true);
      } else {
        Toast.showFlutterToast(
          context,
          "Une erreur est survenue lors de la suppression de la traduction !",
          "success",
        );
      }
    });
  }

  void _onNavigateToUpdate() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return DataTranslate(
            sourceDonnee: traduction.sourceDonnee!,
            action: 'UPDATE',
            updateTraduction: traduction,
          );
        },
      ),
    ).then((value) {
      if (value == true) {
        setState(() {});
      }
    });
  }

  Future<void> _showDeleteConfirm() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirmation',
            style: GoogleFonts.montserrat(
              color: kBlue,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Voulez-vous supprimer cette contribution ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Non',
                style: GoogleFonts.montserrat(
                  color: kRed,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Oui',
                style: GoogleFonts.montserrat(
                  color: kBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteTraduction();
              },
            ),
          ],
        );
      },
    );
  }
}

String getContributionStatus(String? etat) {
  switch (etat) {
    case 'EN_ATTENTE':
      return 'En attente de validation';
    case 'VALIDER':
      return 'Validée';
    case 'REJETER':
      return 'Rejettée';
    default:
      return '';
  }
}

Color getColor(String? status) {
  switch (status) {
    case 'EN_ATTENTE':
      return kOrange;
    case 'VALIDER':
      return kGreen;
    case 'REJETER':
      return kRed;
    default:
      return kOrange;
  }
}
