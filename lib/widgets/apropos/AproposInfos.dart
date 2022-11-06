import 'package:flutter/material.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';

class AProposInfos extends StatelessWidget {
  const AProposInfos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      decoration: BoxDecoration(
        color: kRed,
      ),
    );
  }
}
