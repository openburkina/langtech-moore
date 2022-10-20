import 'package:flutter/material.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';

class TopHome extends StatelessWidget {
  const TopHome({super.key});

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
              "Bienvenue",
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
        Container(
          decoration: BoxDecoration(
            color: Colors.blue[600],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.notifications,
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(8),
        )
      ],
    );
  }
}
