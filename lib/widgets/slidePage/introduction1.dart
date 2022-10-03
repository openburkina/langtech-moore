import 'package:flutter/material.dart';

class Intro1 extends StatefulWidget {
  const Intro1({Key? key}) : super(key: key);

  State<Intro1> createState() => _Intro1PageState();
}

class _Intro1PageState extends State<Intro1> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
       color: Colors.purple,
        child: Center(
          child: Image.asset('images/parent.png',width: 600,height: 300,fit: BoxFit.cover),
        ),
      ),


    );
  }
}
