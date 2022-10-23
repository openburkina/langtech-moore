import 'package:flutter/material.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';

class TopContribution extends StatelessWidget {
  const TopContribution({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "Mes Contributions",
              style: TextStyle(
                color: kWhite,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "20 oct. 2022",
              style: TextStyle(
                color: kWhite,
              ),
            )
          ],
        ),
      ],
    );
  }
}
