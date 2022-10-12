import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import 'emoticone.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  State<Home> createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hi,kizito",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text("16 juill. 2022",
                            style: TextStyle(color: Colors.blue[200]))
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.blue[600],
                          borderRadius: BorderRadius.circular(12)),
                      child: Icon(Icons.notifications, color: Colors.white),
                      padding: const EdgeInsets.all(8),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue[600],
                      borderRadius: BorderRadius.circular(12)),
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Recherche",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Emoticone(iconData: Icons.web),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Sante',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Emoticone(iconData: Icons.mobile_screen_share),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Banque',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Emoticone(iconData: Icons.front_hand),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Agriculture',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Emoticone(iconData: Icons.back_hand),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Transport',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ],
                ),
              ]),
            ),


            SizedBox(height: 20),
            Expanded(
                child: Container(
                  padding: EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.grey[200]),
                  child: Center(child: Column(children: [Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("La liste des sources",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                      Icon(Icons.more_horiz)
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
                    child: ListTile(leading: Container(decoration: BoxDecoration(color:Colors.orange,borderRadius: BorderRadius.circular(30)),child: Icon(Icons.favorite,color: Colors.grey[200])),title: Text("Detection de la panne"),subtitle: Text('2 traductions'),trailing: Icon(Icons.arrow_forward_ios)),
                  ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
                      child: ListTile(leading: Container(decoration: BoxDecoration(color:Colors.orange,borderRadius: BorderRadius.circular(30)),child: Icon(Icons.favorite,color: Colors.grey[200])),title: Text("Analyse tous les éléments "),subtitle: Text('10 traductions'),trailing: Icon(Icons.arrow_forward_ios)),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
                      child: ListTile(leading: Container(decoration: BoxDecoration(color:Colors.orange,borderRadius: BorderRadius.circular(30)),child: Icon(Icons.favorite,color: Colors.grey[200])),title: Text("Contourner l'obstacle"),subtitle: Text('5 traductions'),trailing: Icon(Icons.arrow_forward_ios)),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
                      child: ListTile(leading: Container(
                        decoration: BoxDecoration(color:Colors.orange,borderRadius: BorderRadius.circular(30)),
                          child: Icon(Icons.favorite,color:Colors.grey[200])),title: Text("Booster mes ventes"),subtitle: Text('20 traductions'),trailing: Icon(Icons.arrow_forward_ios),),
                    ),
                  ])),

            ))
          ],
        ),
      ),
    );
  }
}
