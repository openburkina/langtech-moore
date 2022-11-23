import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';

class TraductionInfos extends StatelessWidget {
  final String title;
  final String content;
  final Color? titleColor;
  final Color? contentColor;

  const TraductionInfos({
    super.key,
    required this.title,
    this.content = '',
    this.titleColor = kBlue,
    this.contentColor = kDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: kWhite,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ),
          SizedBox(height: 5),
          Text(
            '$content',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: contentColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
