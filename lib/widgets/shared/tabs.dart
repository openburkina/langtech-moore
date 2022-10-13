import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        // currentIndex: _selectedIndex,
        // selectedItemColor: kBlue,
        // unselectedItemColor: Colors.grey,
        elevation: 0,
        onTap: _onItemTapped,
      ),
    );
  }
}
