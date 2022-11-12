import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';
import 'package:langtech_moore_mobile/models/traduction.dart';
import 'package:langtech_moore_mobile/services/http.dart';
import 'package:langtech_moore_mobile/widgets/contributionPage/top_contribution.dart';
import 'package:langtech_moore_mobile/widgets/home/search_section.dart';
import 'package:langtech_moore_mobile/widgets/shared/loadingSpinner.dart';
import 'package:langtech_moore_mobile/widgets/shared/traduction_list_tile.dart';

class ContributionPage extends StatefulWidget {
  const ContributionPage({super.key});

  @override
  State<ContributionPage> createState() => _ContributionPageState();
}

class _ContributionPageState extends State<ContributionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlue,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  TopContribution(),
                  SizedBox(
                    height: 15,
                  ),
                  SearchSection(
                    advancedSearch: true,
                    function: _openAdvancedSearchModal,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(16, 18, 16, 0),
                color: kGris,
                child: FutureBuilder<List<Traduction>>(
                  future: Http.getAllTraductons(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
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
                                "Vous n'avez pas fait de contributions !",
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
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return TraductionListTile(
                              traduction: snapshot.data![index],
                              update: _updateAfterDelete,
                            );
                          },
                        );
                      }
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Une erreur est survenue lors de la récupération des traductions !",
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
      ),
    );
  }

  void _updateAfterDelete() {
    setState(() {});
  }

  void _openAdvancedSearchModal() {
    _showMyDialog();
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Recherche avancée',
            style: GoogleFonts.montserrat(
              color: kBlue,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
                Text('Would you like to approve of this message?'),
                Text('Would you like to approve of this message?'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Annuler',
                style: GoogleFonts.montserrat(
                  color: kRed,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Rechercher',
                style: GoogleFonts.montserrat(
                  color: kBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
