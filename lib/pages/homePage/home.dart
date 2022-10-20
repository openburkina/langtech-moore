import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:langtech_moore_mobile/config/sharedPreferences/sharedPrefConfig.dart';
import 'package:langtech_moore_mobile/config/sharedPreferences/sharedPrefKeys.dart';
import 'package:langtech_moore_mobile/models/user.dart';
import 'package:langtech_moore_mobile/widgets/home/search_section.dart';
import 'package:langtech_moore_mobile/widgets/home/top_home.dart';
import 'package:langtech_moore_mobile/widgets/shared/category.dart';

import '../../constants/colors.dart';
import '../../widgets/home/emoticone.dart';

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
              child: Column(children: [
                TopHome(),
                SizedBox(
                  height: 15,
                ),
                SearchSection(),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Les domaines de souces de données ?",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Category(
                        icon: Icons.health_and_safety,
                        title: 'Santé',
                      ),
                      Category(
                        icon: Icons.money,
                        title: 'Banque',
                      ),
                      Category(
                        icon: Icons.track_changes,
                        title: 'Agriculture',
                      ),
                      Category(
                        icon: Icons.car_rental,
                        title: 'Transport',
                      ),
                      Category(
                        icon: Icons.school,
                        title: 'Education',
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.grey[200]),
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("La liste des sources",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          Icon(Icons.more_horiz)
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                            leading: Container(
                                decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Icon(Icons.favorite,
                                    color: Colors.grey[200])),
                            title: Text("Detection de la panne"),
                            subtitle: Text('2 traductions'),
                            trailing: Icon(Icons.arrow_forward_ios)),
                      ),
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                            leading: Container(
                                decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Icon(Icons.favorite,
                                    color: Colors.grey[200])),
                            title: Text("Analyse tous les éléments "),
                            subtitle: Text('10 traductions'),
                            trailing: Icon(Icons.arrow_forward_ios)),
                      ),
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                            leading: Container(
                                decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Icon(Icons.favorite,
                                    color: Colors.grey[200])),
                            title: Text("Contourner l'obstacle"),
                            subtitle: Text('5 traductions'),
                            trailing: Icon(Icons.arrow_forward_ios)),
                      ),
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          leading: Container(
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Icon(Icons.favorite,
                                  color: Colors.grey[200])),
                          title: Text("Booster mes ventes"),
                          subtitle: Text('20 traductions'),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
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
