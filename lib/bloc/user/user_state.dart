import 'package:langtech_moore_mobile/models/utilisateur.dart';
import 'package:meta/meta.dart';

@immutable
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

class GetUserInfoState extends UserStates {
  final Utilisateur currentUser;
  GetUserInfoState({
    required this.currentUser,
  });
}
