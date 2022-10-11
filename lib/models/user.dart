class User {
  String? nom;
  String? prenom;
  String? telephone;
  String? email;
  String? login;
  String? password;
  String? typeUtilisateur;
  int? pointFidelite;

  User({
    this.nom = '',
    this.prenom = '',
    this.telephone = '',
    this.email = '',
    this.login = '',
    this.password = '',
    this.typeUtilisateur = '',
    this.pointFidelite = 0,
  });

  User.fromJson(Map<String, dynamic> json) {
    this.nom = json['nom'];
    this.prenom = json['prenom'];
    this.telephone = json['telephone'];
    this.email = json['email'];
    this.login = json['login'];
    this.password = json['password'];
    this.typeUtilisateur = json['typeUtilisateur'];
    this.pointFidelite = json['pointFidelite'] as int;
  }

  Map<String, dynamic> toJson() => {
        'nom': nom,
        'prenom': prenom,
        'telephone': telephone,
        'email': email,
        'login': login,
        'password': password,
        'typeUtilisateur': typeUtilisateur,
        'pointFidelite': pointFidelite,
      };
}
