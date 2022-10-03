import 'package:flutter/material.dart';

class Intro2 extends StatefulWidget {
  const Intro2({Key? key}) : super(key: key);

  State<Intro2> createState() => _Intro2PageState();
}

class _Intro2PageState extends State<Intro2> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
       color: Colors.deepOrange,
      ),
    );
  }
}
