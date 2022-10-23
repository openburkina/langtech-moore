import 'package:flutter/material.dart';
import 'package:langtech_moore_mobile/pages/contribution_page.dart';
import 'package:langtech_moore_mobile/pages/profilPage/profil_page.dart';
import 'package:langtech_moore_mobile/pages/homePage/home.dart';

const List<Widget> tabsItems = [
  Center(
    child: Home(),
  ),
  ContributionPage(),
  ProfilPage(),
];
