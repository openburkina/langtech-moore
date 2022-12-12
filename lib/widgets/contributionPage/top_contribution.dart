import 'package:flutter/material.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';

class TopContribution extends StatefulWidget {
  const TopContribution({super.key});

  @override
  State<TopContribution> createState() => _TopContributionState();
}

class _TopContributionState extends State<TopContribution> {
  String currentDate = '';

  String getCurrentMonth(int month) {
    switch (month) {
      case 1:
        return 'Janvier';
      case 2:
        return 'Février';
      case 3:
        return 'Mars';
      case 4:
        return 'Avril';
      case 5:
        return 'Mai';
      case 6:
        return 'Juin';
      case 7:
        return 'Juillet';
      case 8:
        return 'Août';
      case 9:
        return 'Septembre';
      case 10:
        return 'Octobre';
      case 11:
        return 'Novembre';
      case 12:
        return 'Decembre';
      default:
        return '';
    }
  }

  void _getCurrentDate() {
    DateTime now = new DateTime.now();

    String month = getCurrentMonth(now.month);
    currentDate = "${now.day} $month ${now.year}";
  }

  @override
  void initState() {
    super.initState();
    _getCurrentDate();
  }

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
              "$currentDate",
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
