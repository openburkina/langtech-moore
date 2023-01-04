
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';

class PhoneInputSection extends StatefulWidget {
  final IconData icon;
  final String hint;
  final TextEditingController? normalPhoneNumberController;
  final TextEditingController? formatPhoneNumberController;
  final bool required;
  const PhoneInputSection({
    super.key,
    required this.icon,
    required this.hint,
    this.normalPhoneNumberController,
    this.formatPhoneNumberController,
    this.required = false,
  });

  @override
  _PhoneInputSectionState createState() => _PhoneInputSectionState(
        icon: icon,
        hint: hint,
        normalPhoneNumberController: normalPhoneNumberController,
        formatPhoneNumberController: formatPhoneNumberController,
        required: required,
      );
}

class _PhoneInputSectionState extends State<PhoneInputSection> {
  final IconData icon;
  final String hint;
  final TextEditingController? normalPhoneNumberController;
  final TextEditingController? formatPhoneNumberController;
  late Color borderColor = required ? kRed : kBlue;
  final bool required;

  String initialCountry = 'BF';
  String initialDialCode = '+226';
  late PhoneNumber currentNumber;

  _PhoneInputSectionState({
    required this.icon,
    required this.hint,
    this.normalPhoneNumberController,
    this.formatPhoneNumberController,
    required this.required,
  });

  @override
  void initState() {
    super.initState();
    currentNumber = PhoneNumber(
      isoCode: initialCountry,
      dialCode: initialDialCode,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: InternationalPhoneNumberInput(
        onInputChanged: (PhoneNumber number) {
          normalPhoneNumberController?.text = "${number.phoneNumber}";
        },
        onFieldSubmitted: (String value) {
          formatPhoneNumberController?.text = "$value";
        },
        onInputValidated: (bool value) {},
        selectorConfig: SelectorConfig(
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          trailingSpace: false,
        ),
        ignoreBlank: false,
        spaceBetweenSelectorAndTextField: 0,
        autoValidateMode: AutovalidateMode.disabled,
        selectorTextStyle: GoogleFonts.montserrat(
          fontSize: 20,
          color: kBlue,
        ),
        cursorColor: kRed,
        textStyle: GoogleFonts.montserrat(
          fontSize: 20,
          color: kBlue,
        ),
        initialValue: currentNumber,
        textFieldController: formatPhoneNumberController,
        formatInput: true,
        keyboardType: TextInputType.numberWithOptions(
          signed: true,
          decimal: true,
        ),
        inputDecoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: GoogleFonts.montserrat(
            fontSize: 16,
            color: kBlue,
          ),
        ),
        searchBoxDecoration: InputDecoration(
          hintText: 'Rechercher par code ou par nom ...',
          hintStyle: GoogleFonts.montserrat(
            fontSize: 16,
            color: kBlue,
          ),
        ),
        onSaved: (PhoneNumber number) {},
      ),
    );
  }
}
