import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langtech_moore_mobile/bloc/forgot_password.bloc.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';
import 'package:langtech_moore_mobile/widgets/loginPage/app_logo.dart';
import 'package:langtech_moore_mobile/widgets/loginPage/button_section.dart';
import 'package:langtech_moore_mobile/widgets/loginPage/input_section.dart';
import 'package:langtech_moore_mobile/widgets/shared/loadingSpinner.dart';
import 'package:langtech_moore_mobile/widgets/shared/slidepage.dart';
import 'package:langtech_moore_mobile/widgets/shared/tabs.dart';
import 'package:langtech_moore_mobile/widgets/shared/toast.dart';

class FinishPasswordResetPage extends StatelessWidget {
  final String resetKey;
  const FinishPasswordResetPage({
    super.key,
    required this.resetKey,
  });

  @override
  Widget build(BuildContext context) {
    int delayDuration = 25;
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kBlue,
        elevation: 0,
        title: Text(
          'Changement du mot de passe',
          style: GoogleFonts.montserrat(
            fontSize: 20,
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
              showToast(buildContext, state.errorMessage, "error");
            } else if (state is PasswordResetSuccessState) {
              showToast(buildContext, state.successMessage, "success");
              onNavigatorToHomePage(context);
            }

            return Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: ButtonSection(
                buttonFonction: () =>
                    buildContext.read<PasswordResetBloc>().add(
                          FinishPasswordResetEvent(
                            key: resetKey,
                            newPassword: newPasswordController.text,
                            confirmNewPassword: confirmPasswordController.text,
                          ),
                        ),
                buttonText: "Enregistrer",
                buttonSize: 20,
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 64,
          ),
          AppLogo(),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Text(
              textAlign: TextAlign.center,
              "Veuillez definir un nouveau mot de passe.",
              style: GoogleFonts.montserrat(
                fontSize: 18,
                color: kBlue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          DelayedDisplay(
            delay: Duration(milliseconds: delayDuration * 4),
            child: InputSection(
              icon: Icons.lock_outline,
              hint: 'Entrez le nouveau mot de passe',
              obscureText: true,
              controller: newPasswordController,
              keyboardType: TextInputType.text,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          DelayedDisplay(
            delay: Duration(milliseconds: delayDuration * 5),
            child: InputSection(
              icon: Icons.lock_outline,
              hint: 'Confirmez le nouveau mot de passe',
              obscureText: true,
              controller: confirmPasswordController,
              keyboardType: TextInputType.text,
            ),
          ),
        ],
      )),
    );
  }

  void onNavigatorToHomePage(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Navigator.of(context).pushReplacement(
          SlideRightRoute(
            child: const Tabs(),
            page: const Tabs(),
            direction: AxisDirection.left,
          ),
        );
      },
    );
  }

  void showToast(
    BuildContext context,
    String message,
    String type,
  ) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Toast.showFlutterToast(
        context,
        message,
        type,
      );
    });
  }
}
