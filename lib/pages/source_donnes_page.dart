import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';
import 'package:langtech_moore_mobile/models/source_donnee.dart';
import 'package:langtech_moore_mobile/services/http.dart';
import 'package:langtech_moore_mobile/widgets/home/search_section.dart';
import 'package:langtech_moore_mobile/widgets/shared/data_list_tile.dart';
import 'package:langtech_moore_mobile/widgets/shared/loadingSpinner.dart';

class SourceDonneePage extends StatefulWidget {
  const SourceDonneePage({super.key});

  @override
  State<SourceDonneePage> createState() => _SourceDonneePageState();
}

class _SourceDonneePageState extends State<SourceDonneePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlue,
        title: Text(
          "Sources de données",
          style: GoogleFonts.montserrat(
            color: kWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: kGris,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            child: SearchSection(),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: kGris,
              child: FutureBuilder<List<SourceDonnee>>(
                future: Http.getAllSourcesDonnees(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return DataListTile(
                            sourceDonnee: snapshot.data![index],
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Une erreur est survenue lors de la récupération des sources de données !",
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: kRed,
                        ),
                      ),
                    );
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
    );
  }
}
