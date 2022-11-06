import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';
import 'package:langtech_moore_mobile/models/traduction.dart';
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

  _DetailContributionState({
    required this.traduction,
  });

  @override
  void initState() {
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
              deleteTraduction: _deleteTraduction,
              updateTraduction: () {},
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
              content: "${traduction.etat}",
              contentColor: getColor(traduction.etat),
            ),
            TraductionInfos(
              title: "Note",
              content: "${traduction.note}",
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
