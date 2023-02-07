import 'package:langtech_moore_mobile/models/utilisateur.dart';
import 'package:meta/meta.dart';

@immutable
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

class GetUserInfoEvent extends UserEvent {}
