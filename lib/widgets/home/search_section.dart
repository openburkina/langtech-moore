import 'package:flutter/material.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: kRed,
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            "Rechercher par mot clé...",
            style: TextStyle(
              color: kRed,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
