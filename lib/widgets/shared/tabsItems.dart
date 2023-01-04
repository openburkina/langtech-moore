import 'package:flutter/material.dart';
import 'package:langtech_moore_mobile/pages/contribution.page.dart';
import 'package:langtech_moore_mobile/pages/profil_page.dart';
import 'package:langtech_moore_mobile/pages/home.dart';

const List<Widget> tabsItems = [
  Center(
    child: Home(),
  ),
  ContributionPage(),
  ProfilPage(),
];
