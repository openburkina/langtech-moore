class SourceDonnee {
  int? id;
  String? libelle;
  int? counter;

  SourceDonnee({
    this.id,
    this.libelle = '',
    this.counter = 0,
  });

  SourceDonnee.fromJson(Map<String, dynamic> json) {
    this.id = json['id'] as int;
    this.libelle = json['libelle'];
    this.counter = 0;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'libelle': libelle,
      };
}
