import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:langtech_moore_mobile/config/sharedPreferences/sharedPrefConfig.dart';
import 'package:langtech_moore_mobile/config/sharedPreferences/sharedPrefKeys.dart';
import 'package:langtech_moore_mobile/models/user.dart';
import 'package:langtech_moore_mobile/widgets/home/search_section.dart';
import 'package:langtech_moore_mobile/widgets/home/top_home.dart';
import 'package:langtech_moore_mobile/widgets/shared/data_list_tile.dart';

import '../../constants/colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  State<Home> createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  late User currentUser = new User();

  void _getCurrentUserInfos() {
    SharedPrefConfig.getStringData(SharePrefKeys.USER_INFOS).then((value) {
      setState(() {
        currentUser = User.fromJson(jsonDecode(value)['utilisateur']);
      });
    });
  }

  @override
  void initState() {
    _getCurrentUserInfos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlue,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  TopHome(),
                  SizedBox(
                    height: 15,
                  ),
                  SearchSection(),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(20),
              color: kGris,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sources de données recentes",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Icon(
                    Icons.more_horiz,
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                color: kGris,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      DataListTile(
                        dataLibelle: "Bonjour",
                        counter: 10,
                      ),
                      DataListTile(
                        dataLibelle: "Comment vous allez ?",
                        counter: 0,
                      ),
                      DataListTile(
                        dataLibelle: "Je vais bien et chez vous ?",
                        counter: 6,
                      ),
                      DataListTile(
                        dataLibelle: "Je pars au marché",
                        counter: 3,
                      ),
                      DataListTile(
                        dataLibelle: "Mon enfant part à l'école",
                        counter: 12,
                      ),
                      DataListTile(
                        dataLibelle: "Le pardon est sacré",
                        counter: 0,
                      ),
                      DataListTile(
                        dataLibelle: "Le pardon est sacré",
                        counter: 0,
                      ),
                      DataListTile(
                        dataLibelle:
                            "Le Burkina Faso est un pays de paix et de prospérité. Le Burkina Faso est un pays de paix et de prospérité. Le Burkina Faso est un pays de paix et de prospérité.",
                        counter: 0,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
