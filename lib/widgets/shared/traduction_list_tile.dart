import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';
import 'package:langtech_moore_mobile/models/traduction.dart';
import 'package:langtech_moore_mobile/pages/detail_contribution.page.dart';
import 'package:langtech_moore_mobile/services/http.dart';

class TraductionListTile extends StatefulWidget {
  final Traduction traduction;
  final VoidCallback update;
  const TraductionListTile({
    super.key,
    required this.traduction,
    required this.update,
  });

  @override
  State<TraductionListTile> createState() => _TraductionListTileState(
        traduction: traduction,
      );
}

class _TraductionListTileState extends State<TraductionListTile> {
  Traduction traduction;

  _TraductionListTileState({
    required this.traduction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _getOneTraduction,
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: getColor(widget.traduction.etat),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              widget.traduction.type == 'TEXTE'
                  ? CupertinoIcons.pencil_ellipsis_rectangle
                  : Icons.mic,
              color: kWhite,
            ),
          ),
          title: Text(
            "${widget.traduction.libelle}",
            maxLines: 2,
            style: GoogleFonts.montserrat(
              color: kBlue,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            "${getContributionStatus(widget.traduction.etat)}",
            style: GoogleFonts.montserrat(
              color: getColor(widget.traduction.etat),
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: kBlue,
          ),
        ),
      ),
    );
  }

  void _getOneTraduction() {
    Http.getOneTraduction(widget.traduction.id!).then((value) {
      traduction = value;
      _onNavigateToDetail();
    });
  }

  void _onNavigateToDetail() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return DetailContribution(
          traduction: traduction,
        );
      }),
    ).then((value) {
      if (value == true) {
        super.widget.update.call();
      }
    });

    // if (returnResult == true) {

    // }
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
