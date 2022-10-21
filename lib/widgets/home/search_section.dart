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
      padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: kRed,
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Rechercher par mot clé...",
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: kRed,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
