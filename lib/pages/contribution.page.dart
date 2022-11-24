import 'dart:convert';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';
import 'package:langtech_moore_mobile/models/traduction.dart';
import 'package:langtech_moore_mobile/services/http.dart';
import 'package:langtech_moore_mobile/widgets/contributionPage/top_contribution.dart';
import 'package:langtech_moore_mobile/widgets/home/search_section.dart';
import 'package:langtech_moore_mobile/widgets/shared/loadingSpinner.dart';
import 'package:langtech_moore_mobile/widgets/shared/traduction_list_tile.dart';

import 'dart:developer';

class ContributionPage extends StatefulWidget {
  const ContributionPage({super.key});

  @override
  State<ContributionPage> createState() => _ContributionPageState();
}


class _ContributionPageState extends State<ContributionPage> {
  late String searchKey = '';
  late Traduction searchTraduction = new Traduction();
  final ScrollController _scrollController = new ScrollController();
  late int currentPage = 0;
  late int totalItems = 0;
  late int size = 10;
  List<Traduction> _traductions = [];
  late Future<List<Traduction>> _futureTraduction;

  Future<List<Traduction>> getTraduction(int page) async {
    Response response = await Http.getAllTraductons(page: page, size: size);
    List jsonResponse = convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
    this._traductions.insertAll(0, jsonResponse.map((data) => new Traduction.fromJson(data)).toList());
    this.currentPage++;
    this.totalItems = int.parse(response.headers['x-total-count']!);
    log("SIZE ==> ${_traductions.length}");
    log("TOTAL ==> ${totalItems}");
    return _traductions;
  }


  @override
  void initState() {
    _futureTraduction = getTraduction(currentPage);
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        setState(() {
          if (totalItems > _traductions.length) {
            _futureTraduction = getTraduction(currentPage);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

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
                  future: _futureTraduction,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return emptyContainer();
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          controller: _scrollController,
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
    searchTraduction.etat = null;
    searchTraduction.type = null;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return AlertDialog(
              title: Text(
                'Recherche avancée',
                style: GoogleFonts.montserrat(
                  color: kRed,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Etat de la traduction',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: kBlue,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'En attente de validation',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      leading: Radio<String>(
                        value: 'EN_ATTENTE',
                        groupValue: searchTraduction.etat,
                        onChanged: (String? value) {
                          setState(() {
                            searchTraduction.etat = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Validée',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      leading: Radio<String>(
                        value: 'VALIDER',
                        groupValue: searchTraduction.etat,
                        onChanged: (String? value) {
                          setState(() {
                            searchTraduction.etat = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Rejetté',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      leading: Radio<String>(
                        value: 'REJETER',
                        groupValue: searchTraduction.etat,
                        onChanged: (String? value) {
                          setState(() {
                            searchTraduction.etat = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 16,),
                    Text(
                      'Type de la traduction',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: kBlue,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'TEXTE',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      leading: Radio<String>(
                        value: 'TEXTE',
                        groupValue: searchTraduction.type,
                        onChanged: (String? value) {
                          setState(() {
                            searchTraduction.type = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'AUDIO',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      leading: Radio<String>(
                        value: 'AUDIO',
                        groupValue: searchTraduction.type,
                        onChanged: (String? value) {
                          setState(() {
                            searchTraduction.type = value;
                          });
                        },
                      ),
                    ),
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
