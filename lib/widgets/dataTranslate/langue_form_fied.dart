import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';

class LangueFormField extends StatelessWidget {
  final VoidCallback function;
  const LangueFormField({
    super.key,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        height: 50,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: kGris,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: kBlue,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                "Sélectionner la langue",
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  color: kBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              height: 50,
              width: 25,
              child: Icon(
                Icons.arrow_drop_down,
                size: 35,
                color: kBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
