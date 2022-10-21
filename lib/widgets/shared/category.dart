import 'package:flutter/material.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';

class Category extends StatelessWidget {
  final IconData icon;
  final String title;
  const Category({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: kRed.withOpacity(0.7),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.all(12),
          margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
          child: Center(
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kWhite,
          ),
        ),
      ],
    );
  }
}
