import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';
import 'package:langtech_moore_mobile/widgets/shared/tabsItems.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => new AlertDialog(
            title: Row(
              children: [
                Image.asset(
                  "assets/images/logo.jpg",
                  width: 75,
                  height: 75,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'LangTech',
                  style: GoogleFonts.montserrat(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: kBlue,
                  ),
                ),
              ],
            ),
            content: Text(
              "Voulez-vous quitter l'application ?",
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'Non',
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: kBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text(
                  'Oui',
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: kRed,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Container(
          child: tabsItems.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: ConvexAppBar(
          items: <TabItem>[
            TabItem(
              icon: Icon(
                Icons.home,
                size: _selectedIndex == 0 ? 35 : 25,
                color: _selectedIndex == 0 ? kBlue : kWhite,
              ),
              title: 'Accueil',
            ),
            TabItem(
              icon: Icon(
                Icons.mic_outlined,
                size: _selectedIndex == 1 ? 35 : 25,
                color: _selectedIndex == 1 ? kBlue : kWhite,
              ),
              title: 'Mes contributions',
            ),
            TabItem(
              icon: Icon(
                Icons.person,
                size: _selectedIndex == 2 ? 35 : 25,
                color: _selectedIndex == 2 ? kBlue : kWhite,
              ),
              title: 'Mon Profil',
            ),
          ],
          initialActiveIndex: _selectedIndex,
          activeColor: kWhite,
          color: kWhite,
          backgroundColor: kBlue,
          elevation: 0,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
