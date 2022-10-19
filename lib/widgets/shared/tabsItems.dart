import 'package:flutter/material.dart';
import 'package:langtech_moore_mobile/pages/profilPage/profil_page.dart';
import 'package:langtech_moore_mobile/widgets/home/home.dart';

const List<Widget> tabsItems = [
  Center(
    child: Home(),
  ),
  Center(
    child: const Text('Contributions Page'),
  ),
  ProfilPage(),
];
