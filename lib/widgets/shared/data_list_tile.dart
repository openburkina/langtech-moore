import 'package:flutter/material.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';
import 'package:langtech_moore_mobile/models/source_donnee.dart';
import 'package:langtech_moore_mobile/pages/data_translate.page.dart';

class DataListTile extends StatelessWidget {
  final SourceDonnee sourceDonnee;
  const DataListTile({
    super.key,
    required this.sourceDonnee,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return DataTranslate(
                sourceDonnee: sourceDonnee,
              );
            },
          ),
        );
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
            "${sourceDonnee.libelle}",
            maxLines: 2,
            style: TextStyle(
              color: kBlue,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            "${sourceDonnee.counter == 0 ? 'Aucune traduction' : '${sourceDonnee.counter} traductions '}",
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
