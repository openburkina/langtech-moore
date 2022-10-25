class Langue {
  int? id;
  String? libelle;

  Langue({
    this.id,
    this.libelle,
  });

  Langue.fromJson(Map<String, dynamic> json) {
    this.id = json['id'] as int;
    this.libelle = json['libelle'];
  }

  Map<String, dynamic> toJon() => {
        'id': id,
        'libelle': libelle,
      };
}
