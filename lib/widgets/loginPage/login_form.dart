import 'package:flutter/material.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:langtech_moore_mobile/bloc/user/user.bloc.dart';
import 'package:langtech_moore_mobile/bloc/user/user_event.dart';
import 'package:langtech_moore_mobile/bloc/user/user_state.dart';
import 'package:langtech_moore_mobile/models/loginVM.dart';
import 'package:langtech_moore_mobile/pages/finish_password_reset.page.dart';
import 'package:langtech_moore_mobile/widgets/loginPage/button_section.dart';
import 'package:langtech_moore_mobile/widgets/loginPage/forgot_password.dart';
import 'package:langtech_moore_mobile/widgets/loginPage/input_section.dart';
import 'package:langtech_moore_mobile/widgets/shared/loadingSpinner.dart';
import 'package:langtech_moore_mobile/widgets/shared/phone_input_section.dart';
import 'package:langtech_moore_mobile/widgets/shared/slidepage.dart';
import 'package:langtech_moore_mobile/widgets/shared/tabs.dart';
import 'package:langtech_moore_mobile/widgets/shared/toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  final int delayDuration;

  const LoginForm({super.key, required this.delayDuration});
  @override
  _LoginFormState createState() => _LoginFormState(delayDuration);
}

class _LoginFormState extends State<LoginForm> {
  final int delayDuration;
  TextEditingController normalPhoneNumberController = TextEditingController();
  TextEditingController formatPhoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  late bool isEnaableSpinner = false;
  final _formKey = GlobalKey<FormState>();
  late LoginVM loginVM = new LoginVM();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'BF';
  PhoneNumber number = PhoneNumber(isoCode: 'BF');

  _LoginFormState(this.delayDuration);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          DelayedDisplay(
            delay: Duration(milliseconds: delayDuration * 3),
            child: PhoneInputSection(
              icon: Icons.add,
              hint: 'Numéro de téléphone',
              normalPhoneNumberController: normalPhoneNumberController,
              formatPhoneNumberController: formatPhoneNumberController,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          DelayedDisplay(
            delay: Duration(milliseconds: delayDuration * 4),
            child: InputSection(
              icon: Icons.lock_outline,
              hint: 'Mot de passe',
              obscureText: true,
              controller: passwordController,
              keyboardType: TextInputType.text,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          DelayedDisplay(
            delay: Duration(milliseconds: delayDuration * 5),
            child: ForgotPassword(),
          ),
          const SizedBox(
            height: 30,
          ),
          DelayedDisplay(
            delay: Duration(milliseconds: delayDuration * 6),
            child: BlocBuilder<UserBloc, UserStates>(
              builder: (blocContext, state) {
                if (state is UserLoadingState) {
                  return const LoadingSpinner();
                } else if (state is UserErrorState) {
                  showToast(
                    blocContext,
                    state.errorMessage,
                    "error",
                  );
                } else if (state is UserSuccessState) {
                  showToast(
                    blocContext,
                    state.successMessage,
                    "success",
                  );
                  onNavigatorToHomePage(context);
                } else if (state is SigninResetPasswordState) {
                  onNavigatorToUpdatePassword(
                    context,
                    state.resetKey,
                  );
                }

                return ButtonSection(
                  buttonText: 'Se connecter',
                  buttonSize: 20,
                  buttonFonction: () {
                    String phoneNumber =
                        normalPhoneNumberController.text.replaceAll('+', '');
                    String password = passwordController.text.trim();
                    blocContext.read<UserBloc>().add(
                          SigninEvent(
                            username: phoneNumber,
                            password: password,
                          ),
                        );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void showToast(BuildContext context, String message, String type) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Toast.showFlutterToast(
        context,
        message,
        type,
      );
    });
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

  void onNavigatorToUpdatePassword(BuildContext context, String resetKey) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Navigator.of(context).pushReplacement(
          SlideRightRoute(
            child: FinishPasswordResetPage(
              resetKey: resetKey,
            ),
            page: FinishPasswordResetPage(
              resetKey: resetKey,
            ),
            direction: AxisDirection.left,
          ),
        );
      },
    );
  }
}
