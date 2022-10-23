import 'package:flutter/material.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';
import 'package:langtech_moore_mobile/models/source_donnee.dart';
import 'package:langtech_moore_mobile/models/traduction.dart';
import 'package:langtech_moore_mobile/pages/data_translate.dart';

class TraductionListTile extends StatelessWidget {
  final Traduction traduction;
  const TraductionListTile({
    super.key,
    required this.traduction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DataTranslate(
            sourceDonnee: new SourceDonnee(),
          );
        }));
      },
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
              color: kOrange,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              Icons.transcribe,
              color: kWhite,
            ),
          ),
          title: Text(
            "${traduction.libelle}",
            maxLines: 2,
            style: TextStyle(
              color: kBlue,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            "${traduction.etat}",
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: kBlue,
          ),
        ),
      ),
    );
  }
}
