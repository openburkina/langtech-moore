// Event
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:langtech_moore_mobile/models/keyAndPassword.model.dart';
import 'package:langtech_moore_mobile/models/mResponse.dart';
import 'package:langtech_moore_mobile/services/http.dart';
import 'dart:convert' as convert;

abstract class PasswordResetEvent {}

class InitPasswordResetEvent extends PasswordResetEvent {
  final String phone;
  InitPasswordResetEvent({
    required this.phone,
  });
}

class FinishPasswordResetEvent extends PasswordResetEvent {
  final String key;
  final String newPassword;
  final String confirmNewPassword;
  FinishPasswordResetEvent({
    required this.key,
    required this.newPassword,
    required this.confirmNewPassword,
  });
}

// States
abstract class PasswordResetState {}

class PasswordResetSuccessState extends PasswordResetState {
  final String successMessage;
  PasswordResetSuccessState({
    required this.successMessage,
  });
}

class PasswordResetErrorState extends PasswordResetState {
  final String errorMessage;
  PasswordResetErrorState({
    required this.errorMessage,
  });
}

class PasswordResetInitialState extends PasswordResetState {}

class PasswordResetLoadingState extends PasswordResetState {}

// Bloc
class PasswordResetBloc extends Bloc<PasswordResetEvent, PasswordResetState> {
  PasswordResetBloc() : super(PasswordResetInitialState()) {
    on((InitPasswordResetEvent event, emit) async {
      String phone = event.phone;
      if (phone == '') {
        emit(
          PasswordResetErrorState(
            errorMessage: "Le numéro de téléphone est obligatoire !",
          ),
        );
      } else {
        emit(
          PasswordResetLoadingState(),
        );
        try {
          Response response = await Http.onInitResetPassword(phone);
          if (response.statusCode == 200) {
            Map<String, dynamic> jsonResponse =
                convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
            MResponse mResponse = MResponse.fromJson(jsonResponse);
            if (mResponse.code == "0") {
              emit(
                PasswordResetSuccessState(
                  successMessage: "${mResponse.msg}",
                ),
              );
            } else {
              emit(
                PasswordResetErrorState(
                  errorMessage: "${mResponse.msg}",
                ),
              );
            }
          } else {
            emit(
              PasswordResetErrorState(
                errorMessage:
                    "Une erreur est survenue lors de la réinitialisation du mot de passe !",
              ),
            );
          }
        } catch (e) {
          log(e.toString());
          emit(
            PasswordResetErrorState(
              errorMessage:
                  "Une erreur est survenue lors de la réinitialisation du mot de passe !",
            ),
          );
        }
      }
    });

    on((FinishPasswordResetEvent event, emit) async {
      String newPassword = event.newPassword;
      String confirmNewPassword = event.confirmNewPassword;

      if (newPassword == '') {
        emit(
          PasswordResetErrorState(
            errorMessage: "Le nouveau mot de passe est obligatoire !",
          ),
        );
      } else if (newPassword != confirmNewPassword) {
        emit(
          PasswordResetErrorState(
            errorMessage:
                "La confirmation du nouveau de passe est incorrecte !",
          ),
        );
      } else {
        KeyAndPassword keyAndPassword = KeyAndPassword();
        keyAndPassword.key = event.key;
        keyAndPassword.newPassword = newPassword;
        await onFinishPasswordReset(keyAndPassword, emit);
      }
    });
  }

  Future<void> onFinishPasswordReset(
    KeyAndPassword keyAndPassword,
    Emitter<PasswordResetState> emit,
  ) async {
    try {
      Response response = await Http.onFinishPasswordReset(keyAndPassword);
      if (response.statusCode == 200) {
        emit(
          PasswordResetSuccessState(
            successMessage: "Votre mot de passe a été changé avec succès !",
          ),
        );
      } else {
        emit(
          PasswordResetErrorState(
            errorMessage:
                "Une erreur est survenue lors du changement du mot de passe !",
          ),
        );
      }
    } catch (e) {
      emit(
        PasswordResetErrorState(
          errorMessage:
              "Une erreur est survenue lors du changement du mot de passe !",
        ),
      );
    }
  }
}
