
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langtech_moore_mobile/models/source_donnee.dart';
import 'package:langtech_moore_mobile/pages/source_donnes_page.dart';
import 'package:langtech_moore_mobile/services/http.dart';
import 'package:langtech_moore_mobile/widgets/home/top_home.dart';
import 'package:langtech_moore_mobile/widgets/shared/data_list_tile.dart';
import 'package:langtech_moore_mobile/widgets/shared/loadingSpinner.dart';

import '../constants/colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  State<Home> createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlue,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(2),
        child: Container(
          color: kBlue,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  TopHome(),
                  SizedBox(
                    height: 15,
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
                    "Sources de données récentes",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: kBlue,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return SourceDonneePage();
                        }),
                      );
                    },
                    child: Container(
                      height: 32,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 8),
                      decoration: BoxDecoration(
                        color: kBlue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          "Voir Plus",
                          style: GoogleFonts.montserrat(
                            color: kWhite,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                color: kGris,
                child: FutureBuilder<List<SourceDonnee>>(
                  future: Http.getAllSourcesDonnees(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return emptyContainer();
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return DataListTile(
                              sourceDonnee: snapshot.data![index],
                            );
                          },
                        );
                      }
                    } else if (snapshot.hasError) {
                      return errorContainer();
                    }
                    return Center(
                      child: LoadingSpinner(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget emptyContainer() {
    return Center(
      child: Container(
        width: double.infinity,
        height: 75,
        decoration: BoxDecoration(
          color: kOrange,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            "Aucune source de donnée trouvée !",
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: kWhite,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget errorContainer() {
    return Center(
      child: Container(
        width: double.infinity,
        height: 75,
        decoration: BoxDecoration(
          color: kRed,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            "Une erreur est survenue lors de la récupération des sources de données !",
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: kWhite,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
