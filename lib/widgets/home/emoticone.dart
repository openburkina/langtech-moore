import 'package:flutter/material.dart';

class Emoticone extends StatelessWidget {
  final IconData iconData;
  const Emoticone({Key? key,required this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue[600], borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.all(12),
      child: Center(
        child: Icon(
          iconData,
          color: Colors.white,
        ),
      ),
    );
  }
}
