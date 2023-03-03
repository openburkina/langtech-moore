import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langtech_moore_mobile/bloc/forgot_password.bloc.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';
import 'package:langtech_moore_mobile/widgets/loginPage/app_logo.dart';
import 'package:langtech_moore_mobile/widgets/loginPage/button_section.dart';
import 'package:langtech_moore_mobile/widgets/shared/loadingSpinner.dart';
import 'package:langtech_moore_mobile/widgets/shared/phone_input_section.dart';
import 'package:langtech_moore_mobile/widgets/shared/toast.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    int delayDuration = 10;
    TextEditingController normalPhoneNumberController = TextEditingController();
    TextEditingController formatPhoneNumberController = TextEditingController();
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kBlue,
        elevation: 0,
        title: Text(
          "Mot de passe oublié !",
          style: GoogleFonts.montserrat(
            fontSize: 18,
            color: kWhite,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 75,
        child: BlocBuilder<PasswordResetBloc, PasswordResetState>(
          builder: (buildContext, state) {
            if (state is PasswordResetLoadingState) {
              return const LoadingSpinner();
            } else if (state is PasswordResetErrorState) {
              showToast(buildContext, state.errorMessage, "error",
                  formatPhoneNumberController.text);
            } else if (state is PasswordResetSuccessState) {
              showToast(buildContext, state.successMessage, "success",
                  formatPhoneNumberController.text);
            }

            return Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: ButtonSection(
                buttonText: 'Envoyer',
                buttonFonction: () =>
                    buildContext.read<PasswordResetBloc>().add(
                          InitPasswordResetEvent(
                            phone: normalPhoneNumberController.text
                                .replaceAll('+', '')
                                .trim(),
                          ),
                        ),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              DelayedDisplay(
                delay: Duration(milliseconds: delayDuration),
                child: AppLogo(),
              ),
              SizedBox(
                height: 20,
              ),
              DelayedDisplay(
                delay: Duration(milliseconds: delayDuration * 2),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Text(
                    "Un mot de passe sera envoyé à ce numéro de téléphone !",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: kBlue,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              DelayedDisplay(
                delay: Duration(milliseconds: delayDuration * 3),
                child: PhoneInputSection(
                  icon: Icons.add,
                  hint: 'Numéro de téléphone',
                  normalPhoneNumberController: normalPhoneNumberController,
                  formatPhoneNumberController: formatPhoneNumberController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showToast(
      BuildContext context, String message, String type, String phone) {
    if (phone != '') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Toast.showFlutterToast(
          context,
          message,
          type,
        );

        if (type == 'success') {
          Navigator.pop(context);
        }
      });
    }
  }
}
