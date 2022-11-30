
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';
import 'package:langtech_moore_mobile/models/source_donnee.dart';
import 'package:langtech_moore_mobile/services/http.dart';
import 'package:langtech_moore_mobile/widgets/home/search_section.dart';
import 'package:langtech_moore_mobile/widgets/shared/data_list_tile.dart';
import 'package:langtech_moore_mobile/widgets/shared/loadingSpinner.dart';
import 'dart:developer';

class SourceDonneePage extends StatefulWidget {
  const SourceDonneePage({super.key});

  @override
  State<SourceDonneePage> createState() => _SourceDonneePageState();
}

class _SourceDonneePageState extends State<SourceDonneePage> {
  late String searchKey = '';
  final int _numberOfPage = 10;
  final PagingController<int, SourceDonnee> _pagingController = PagingController(firstPageKey: 0);

  String onSearch(String inputSearchKey) {
    setState(() {
      searchKey = inputSearchKey;
    });
    return searchKey;
  }

  Future<void> _getSourceDeDonnees(int pageKey) async {
    List<SourceDonnee> sourcesDonnees = await Http.getAllSourcesDonnees( page: pageKey, size: _numberOfPage,);
    final isLastPage = sourcesDonnees.length < _numberOfPage;
    if (isLastPage) {
      _pagingController.appendLastPage(sourcesDonnees);
    } else {
      final nextPageKey = pageKey + sourcesDonnees.length;
      _pagingController.appendPage(sourcesDonnees, nextPageKey);
    }
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _getSourceDeDonnees(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

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
            child: SearchSection(
              onSearch: onSearch,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: kGris,
              child: RefreshIndicator(
                onRefresh: () => Future.sync(() => _pagingController.refresh()),
                child: PagedListView<int, SourceDonnee>(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<SourceDonnee>(
                    itemBuilder: (context, item, index) =>
                      item.libelle
                      .toString()
                      .toLowerCase()
                      .contains(searchKey)
                      ? DataListTile(sourceDonnee: item,) : Container(),
                  ),
                ),
              ),
            ),
          ),
        ],
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

/**
 *
 * Expanded(
    child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
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
    return snapshot.data![index].libelle
    .toString()
    .toLowerCase()
    .contains(searchKey)
    ? DataListTile(
    sourceDonnee: snapshot.data![index],
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
 *
 */