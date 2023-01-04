import 'package:langtech_moore_mobile/models/user.dart';

class Utilisateur {
  int? id;
  String? nom;
  String? prenom;
  String? telephone;
  String? email;
  String? login;
  String? password;
  String? typeUtilisateur;
  int? pointFidelite;
  User? user;

  Utilisateur({
    this.nom = '',
    this.prenom = '',
    this.telephone = '',
    this.email = '',
    this.login = '',
    this.password = '',
    this.typeUtilisateur = '',
    this.pointFidelite = 0,
    this.user,
  });

  Utilisateur.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.nom = json['nom'];
    this.prenom = json['prenom'];
    this.telephone = json['telephone'];
    this.email = json['email'];
    this.login = json['login'];
    this.password = json['password'];
    this.typeUtilisateur = json['typeUtilisateur'];
    this.pointFidelite = json['pointFidelite'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nom': nom,
        'prenom': prenom,
        'telephone': telephone,
        'email': email,
        'login': login,
        'password': password,
        'typeUtilisateur': typeUtilisateur,
        'pointFidelite': pointFidelite,
      };

  @override
  String toString() {
    return 'Utilisateur{id: $id, nom: $nom, prenom: $prenom, telephone: $telephone, email: $email, login: $login, password: $password, typeUtilisateur: $typeUtilisateur, pointFidelite: $pointFidelite}';
  }
}
