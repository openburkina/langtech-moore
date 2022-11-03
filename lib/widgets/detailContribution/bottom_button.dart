import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';

class BottomButtom extends StatelessWidget {
  final VoidCallback deleteTraduction;
  final VoidCallback updateTraduction;
  BottomButtom({
    super.key,
    required this.deleteTraduction,
    required this.updateTraduction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton.icon(
            onPressed: deleteTraduction,
            style: ElevatedButton.styleFrom(
              primary: kRed,
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 10,
              ),
            ),
            icon: Icon(Icons.delete),
            label: Text(
              'Supprimer',
              style: GoogleFonts.montserrat(
                fontSize: 16,
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: updateTraduction,
            style: ElevatedButton.styleFrom(
              primary: kBlue,
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 10,
              ),
            ),
            icon: Icon(Icons.update),
            label: Text(
              'Modifier',
              style: GoogleFonts.montserrat(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
