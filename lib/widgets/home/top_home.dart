import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langtech_moore_mobile/bloc/user/user.bloc.dart';
import 'package:langtech_moore_mobile/bloc/user/user_event.dart';
import 'package:langtech_moore_mobile/bloc/user/user_state.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';

class TopHome extends StatefulWidget {
  const TopHome({super.key});

  @override
  State<TopHome> createState() => _TopHomeState();
}

class _TopHomeState extends State<TopHome> {
  String currentDate = '';

  String getCurrentMonth(int month) {
    switch (month) {
      case 1:
        return 'Janvier';
      case 2:
        return 'Février';
      case 3:
        return 'Mars';
      case 4:
        return 'Avril';
      case 5:
        return 'Mai';
      case 6:
        return 'Juin';
      case 7:
        return 'Juillet';
      case 8:
        return 'Août';
      case 9:
        return 'Septembre';
      case 10:
        return 'Octobre';
      case 11:
        return 'Novembre';
      case 12:
        return 'Decembre';
      default:
        return '';
    }
  }

  void _getCurrentDate() {
    DateTime now = new DateTime.now();
    String month = getCurrentMonth(now.month);
    currentDate = "${now.day} $month ${now.year}";
  }

  @override
  void initState() {
    super.initState();
    _getCurrentDate();
    context.read<UserBloc>().add(GetUserInfoEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "Bienvenue !",
              style: GoogleFonts.montserrat(
                color: kWhite,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 8),
            BlocBuilder<UserBloc, UserStates>(
              builder: (context, state) {
                String name = "";
                if (state is GetUserInfoState) {
                  name = "${state.currentUser.nom} ${state.currentUser.prenom}";
                }
                return Text(
                  name,
                  style: GoogleFonts.montserrat(
                    color: kWhite,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                );
              },
            ),
            SizedBox(height: 8),
            Text(
              "$currentDate",
              style: GoogleFonts.montserrat(
                color: kWhite,
              ),
            )
          ],
        ),
        // Container(
        //   decoration: BoxDecoration(
        //     color: Colors.blue[600],
        //     borderRadius: BorderRadius.circular(12),
        //   ),
        //   child: Icon(
        //     Icons.notifications,
        //     color: Colors.white,
        //   ),
        //   padding: const EdgeInsets.all(8),
        // )
      ],
    );
  }
}
