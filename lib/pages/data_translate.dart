import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';
import 'package:langtech_moore_mobile/models/source_donnee.dart';
import 'package:langtech_moore_mobile/widgets/loginPage/button_section.dart';

class DataTranslate extends StatefulWidget {
  final SourceDonnee sourceDonnee;
  const DataTranslate({
    super.key,
    required this.sourceDonnee,
  });

  @override
  State<DataTranslate> createState() => _DataTranslate(
        sourceDonnee: sourceDonnee,
      );
}

class _DataTranslate extends State<DataTranslate> {
  final SourceDonnee sourceDonnee;
  final List<SelectedListItem> _listLanguages = [
    SelectedListItem(
      name: "MOORE",
      value: "MOORE",
    ),
    SelectedListItem(
      name: "DIOULA",
      value: "DIOULA",
    ),
    SelectedListItem(
      name: "FULFUDE",
      value: "FULFUDE",
    ),
    SelectedListItem(
      name: "GULMATCHE",
      value: "GULMATCHE",
    ),
  ];

  _DataTranslate({
    required this.sourceDonnee,
  });
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlue,
        title: Text(
          'Traduction de la données',
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ButtonSection(
          buttonFonction: () {},
          buttonText: "Enregistrer",
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(5, 10, 0, 10),
                child: Text(
                  'Données à traduire',
                  style: GoogleFonts.montserrat(
                    fontSize: 22,
                    color: kBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: kGris,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: kBlue,
                    width: 2,
                  ),
                ),
                child: Text(
                  '${sourceDonnee.libelle}',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    color: kBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 75,
                    width: (width / 10) * 4,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: kBlue,
                        width: 3,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        CupertinoIcons.pencil_ellipsis_rectangle,
                        size: 50,
                        color: kBlue,
                      ),
                    ),
                  ),
                  Container(
                    height: 75,
                    width: (width / 10) * 4,
                    decoration: BoxDecoration(
                      color: kBlue,
                      border: Border.all(
                        color: kBlue,
                        width: 3,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.mic,
                        size: 50,
                        color: kWhite,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: onTextFieldTap,
                child: Container(
                  height: 50,
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: kGris,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: kBlue,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Sélectionner la langue",
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            color: kBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 25,
                        child: Icon(
                          Icons.arrow_drop_down,
                          size: 35,
                          color: kBlue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 200,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: kGris,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: kBlue,
                    width: 2,
                  ),
                ),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Entrez la traduction',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintStyle: GoogleFonts.montserrat(
                      fontSize: 18,
                      color: kBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    color: kBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTextFieldTap() {
    DropDownState(
      DropDown(
        isSearchVisible: false,
        bottomSheetTitle: Text(
          "Langue de traduction",
          style: GoogleFonts.montserrat(
            fontSize: 18,
            color: kBlue,
            fontWeight: FontWeight.w600,
          ),
        ),
        submitButtonChild: Text(
          'Fermer',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            color: kBlue,
            fontWeight: FontWeight.w600,
          ),
        ),
        data: _listLanguages,
        selectedItems: (List<dynamic> selectedList) {
          List<String> list = [];
          for (var item in selectedList) {
            if (item is SelectedListItem) {
              setState(() {
                // motifRejet.id = int.parse(item.value!);
                // motifRejet.name = item.name;
              });
              list.add(item.name);
            }
          }
        },
      ),
    ).showModal(context);
  }
}
