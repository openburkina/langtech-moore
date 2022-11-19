import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';

class SearchSection extends StatelessWidget {
  final bool advancedSearch;
  final VoidCallback? function;
  final String Function(String)? onSearch;
  const SearchSection({
    super.key,
    this.advancedSearch = false,
    this.function,
    this.onSearch,
  });

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
              onChanged: onSearch,
              decoration: InputDecoration(
                hintText: "Rechercher par mot clé...",
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: kRed,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          advancedSearch
              ? InkWell(
                  onTap: function,
                  child: Container(
                    width: 50,
                    child: Center(
                      child: Icon(
                        FontAwesomeIcons.sliders,
                        color: kBlue,
                      ),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
