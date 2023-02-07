import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';

class Parameter extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subTitle;
  final VoidCallback function;
  const Parameter({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: 80,
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kWhite,
        ),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: kBlue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: kBlue,
                  size: 25,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$title',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: kBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '$subTitle',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 60,
              width: 60,
              child: Center(
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: kBlue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
