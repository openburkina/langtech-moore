import 'package:flutter/material.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            photoProfil,
            const SizedBox(
              height: 20,
            ),
            postFollowSection,
            apropos,
            buttonSection,
          ],
        ),
      ),
    );
  }
}


Widget photoProfil = Container(
  padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
  width: double.infinity,
  decoration: const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [kBlue, kRed],
    ),
  ),
  child: Column(
    children: [
      Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(width: 2, color: kWhite),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Icon(Icons.person, size: 100, color: kBlue,),
        ),
      ),
      usernameSection,
      fonctionSection,
    ],
  ),
);

Widget usernameSection = Container(
  margin: const EdgeInsets.fromLTRB(0, 20, 0, 5),
  child: const Text(
    'Hubert SAWADOGO',
    style: TextStyle(
      color: Colors.white,
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),
  ),
);

Widget fonctionSection = Container(
  child: const Text(
    'UI/UX Design - FrontEnd Developper',
    style: TextStyle(
      color: Colors.white,
      fontSize: 20,
    ),
  ),
);

Widget postFollowSection = Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    post,
    followers,
    follow,
  ],
);

Widget post = Column(
  children: const [
    Text(
      'Posts',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: kBlue,
      ),
    ),
    Text(
      '21299',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: kBlue,
      ),
    )
  ],
);

Widget followers = Column(
  children: const [
    Text(
      'Followers',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: kBlue,
      ),
    ),
    Text(
      '21299',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: kBlue,
      ),
    )
  ],
);

Widget follow = Column(
  children: const [
    Text(
      'Follow',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: kBlue,
      ),
    ),
    Text(
      '21299',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: kBlue,
      ),
    )
  ],
);

Widget apropos = Container(
  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: const [
      Text(
        'A propos',
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
      ),
      Text(
        "Elon Musk, né le 28 juin 1971 à Pretoria, est un entrepreneur, chef d'entreprise et ingénieur sud-africain, naturalisé canadien en 1988 puis américain en 2002.",
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
      )
    ],
  ),
);

Widget buttonSection = ElevatedButton(
  style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
  onPressed: () {},
  child: Container(
    padding: const EdgeInsets.fromLTRB(120, 15, 120, 15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      gradient: const LinearGradient(
        colors: [
          Colors.blue,
          Colors.cyan,
        ],
      ),
    ),
    child: const Text(
      'Suivre',
      style: TextStyle(
        fontSize: 25,
      ),
    ),
  ),
);