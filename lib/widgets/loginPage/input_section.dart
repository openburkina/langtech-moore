import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';

class InputSection extends StatelessWidget {
  final IconData icon;
  final String hint;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  const InputSection({
    super.key,
    required this.icon,
    required this.hint,
    required this.obscureText,
    required this.controller,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        border: Border.all(color: kBlue, width: 2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
              color: kBlue,
            ),
            child: Center(
              child: Icon(
                icon,
                color: kWhite,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              style: GoogleFonts.montserrat(
                fontSize: 20,
                color: kBlue,
              ),
              obscureText: obscureText,
              obscuringCharacter: '*',
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                errorStyle: TextStyle(fontSize: 0, height: 0),
                suffixIcon: obscureText
                    ? Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Icon(
                          Icons.visibility_off,
                          color: kBlue,
                        ),
                      )
                    : null,
                hintStyle: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: kBlue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
