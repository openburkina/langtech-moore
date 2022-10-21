import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';
import 'package:langtech_moore_mobile/widgets/loginPage/button_section.dart';

class DataTranslate extends StatefulWidget {
  final String dataLibelle;
  const DataTranslate({
    super.key,
    required this.dataLibelle,
  });

  @override
  State<DataTranslate> createState() => _DataTranslate(
        dataLibelle: dataLibelle,
      );
}

class _DataTranslate extends State<DataTranslate> {
  final String dataLibelle;

  _DataTranslate({
    required this.dataLibelle,
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
                height: 200,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: kGris,
                  border: Border.all(
                    color: kBlue,
                    width: 2,
                  ),
                ),
                child: Text(
                  '$dataLibelle',
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
                    height: 100,
                    width: (width / 10) * 4,
                    decoration: BoxDecoration(
                      color: kOrange,
                      border: Border.all(
                        color: kBlue,
                        width: 3,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add_chart,
                        size: 50,
                        color: kWhite,
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
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
              Container(
                height: 200,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: kGris,
                  border: Border.all(
                    color: kBlue,
                    width: 2,
                  ),
                ),
                child: Text(
                  'Entrez la traduction',
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
}
