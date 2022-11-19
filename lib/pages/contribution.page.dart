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
  late String searchKey = '';

  String onSearch(String inputSearchKey) {
    setState(() {
      searchKey = inputSearchKey;
    });
    return searchKey;
  }

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
                    onSearch: onSearch,
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
                        return emptyContainer();
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return snapshot.data![index].libelle
                                    .toString()
                                    .toLowerCase()
                                    .contains(searchKey)
                                ? TraductionListTile(
                                    traduction: snapshot.data![index],
                                    update: _updateAfterDelete,
                                  )
                                : Container();
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
              children: <Widget>[
                Radio(value: 'AUDIO', groupValue: 3, onChanged: (value) {}),
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
            "Aucune contribution trouvée !",
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
            "Une erreur est survenue lors de la récupération des contributions !",
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
