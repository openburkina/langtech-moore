// Event
import 'dart:convert';
import 'dart:convert' as convert;
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:langtech_moore_mobile/config/sharedPreferences/sharedPrefConfig.dart';
import 'package:langtech_moore_mobile/config/sharedPreferences/sharedPrefKeys.dart';
import 'package:langtech_moore_mobile/models/loginVM.dart';
import 'package:langtech_moore_mobile/models/utilisateur.dart';
import 'package:langtech_moore_mobile/services/http.dart';

abstract class UserEvent {}

class SigninEvent extends UserEvent {
  final String username;
  final String password;
  SigninEvent({
    required this.username,
    required this.password,
  });
}

class SignupEvent extends UserEvent {
  final Utilisateur utilisateur;
  SignupEvent({
    required this.utilisateur,
  });
}

// States
abstract class UserStates {}

class UserSuccessState extends UserStates {
  final String successMessage;
  UserSuccessState({
    required this.successMessage,
  });
}

class UserErrorState extends UserStates {
  final String errorMessage;
  UserErrorState({
    required this.errorMessage,
  });
}

class SigninResetPasswordState extends UserStates {
  final String resetKey;
  SigninResetPasswordState({
    required this.resetKey,
  });
}

class UserInitialState extends UserStates {}

class UserLoadingState extends UserStates {}

// Bloc
class UserBloc extends Bloc<UserEvent, UserStates> {
  UserBloc() : super(UserInitialState()) {
    on((SigninEvent event, emit) async {
      await getSigninInfos(event, emit);
    });
  }

  /**
   * Get Signin infos and verify its validity
   * [event] is the Signin Event
   * [emit] is the state
   */
  Future<void> getSigninInfos(
      SigninEvent event, Emitter<UserStates> emit) async {
    String username = event.username;
    String password = event.password;

    if (username == '') {
      emit(
        UserErrorState(
          errorMessage: "Le numéro de téléphone est obligatoire !",
        ),
      );
    } else if (password == '') {
      emit(
        UserErrorState(
          errorMessage: "Le mot de passe est obligatoire !",
        ),
      );
    } else {
      await _onLogin(username, password, emit);
    }
  }

  /**
   * Proceded to login after verify signin infos
   * [username] is the username of user
   * [password] is the password of user
   * [emit] is the state for emitter
   */
  Future<void> _onLogin(
      String username, String password, Emitter<UserStates> emit) async {
    emit(UserLoadingState());
    LoginVM loginVM = LoginVM(username: username, password: password);
    try {
      Response response = await Http.onAuthenticate(loginVM);
      if (response.statusCode == 200) {
        var body = response.body;
        var bodyBytes = response.bodyBytes;
        var jsonResponse = jsonDecode(convert.utf8.decode(response.bodyBytes));
        var prenomEncoded =
            convert.utf8.encode(jsonDecode(body)["utilisateur"]["prenom"]);
        log("${convert.utf8.decode(prenomEncoded)}");
        log("${jsonDecode(convert.utf8.decode(response.bodyBytes))["utilisateur"]["prenom"]}");
        // log("${Utilisateur.fromJson(jsonResponse)}");
        await _saveUserInfos(response.body, emit);
      } else if (response.statusCode == 401) {
        emit(
          UserErrorState(
            errorMessage: jsonDecode(response.body)['detail'],
          ),
        );
      } else {
        emit(
          UserErrorState(
            errorMessage: "Une erreur est survenue lors de la connexion !",
          ),
        );
      }
    } catch (e) {
      log(e.toString());
      emit(
        UserErrorState(
          errorMessage: "Une erreur est survenue lors de la connexion !",
        ),
      );
    }
  }

  Future<void> _saveUserInfos(
      String userInfos, Emitter<UserStates> emit) async {
    bool saveUserInfosResponse = await SharedPrefConfig.saveStringData(
      SharePrefKeys.USER_INFOS,
      userInfos,
    );
    if (saveUserInfosResponse) {
      bool saveRegisterResponse = await SharedPrefConfig.saveBoolData(
        SharePrefKeys.IS_REGISTERED,
        true,
      );

      if (saveRegisterResponse) {
        Utilisateur registerUser = Utilisateur.fromJson(
          jsonDecode(userInfos)['utilisateur'],
        );

        if (registerUser.user?.resetKey == null ||
            registerUser.user?.resetKey == '') {
          emit(
            UserSuccessState(
              successMessage: "Bienvenue ${registerUser.prenom} !",
            ),
          );
        } else {
          emit(
            SigninResetPasswordState(
              resetKey: registerUser.user!.resetKey!,
            ),
          );
        }
      } else {
        emit(
          UserErrorState(
            errorMessage: "Une erreur est survenue lors de l'opération !",
          ),
        );
      }
    } else {
      emit(
        UserErrorState(
          errorMessage: "Une erreur est survenue lors de l'opération !",
        ),
      );
    }
  }
}
