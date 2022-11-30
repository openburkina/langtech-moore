import 'package:langtech_moore_mobile/models/langue.dart';
import 'package:langtech_moore_mobile/models/source_donnee.dart';
import 'package:langtech_moore_mobile/models/user.dart';

class Traduction {
  int? id;
  String? libelle;
  String? contenuTexte;
  String? contenuAudio;
  String? contenuAudioContentType;
  String? type;
  int? note;
  String? etat;
  String? createdDate;
  String? motif;
  String? mois;
  Langue? langue;
  SourceDonnee? sourceDonnee;
  User? utilisateur;

  Traduction({
    this.id,
    this.libelle,
    this.contenuTexte,
    this.contenuAudio,
    this.contenuAudioContentType,
    this.type,
    this.note,
    this.etat,
    this.createdDate,
    this.motif,
    this.mois,
    this.langue,
    this.sourceDonnee,
    this.utilisateur,
  });

  Traduction.fromJson(Map<String, dynamic> json) {
    this.id = json['id'] as int;
    this.libelle = json['libelle'];
    this.contenuTexte = json['contenuTexte'];
    this.contenuAudio = json['contenuAudio'];
    this.contenuAudioContentType = json['contenuAudioContentType'];
    this.type = json['type'];
    this.note = json['note'] == Null ? 0 : json['note'] as int;
    this.etat = json['etat'];
    this.createdDate = json['createdDate'];
    this.motif = json['motif'];
    this.mois = json['mois'];
    this.langue = Langue.fromJson(json['langue']);
    this.sourceDonnee = SourceDonnee.fromJson(json['sourceDonnee']);
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'libelle': this.libelle,
        'contenuTexte': this.contenuTexte,
        'contenuAudio': this.contenuAudio,
        'contenuAudioContentType': this.contenuAudioContentType,
        'type': this.type,
        'note': this.note,
        'etat': this.etat,
        'langue': {
          'id': this.langue?.id,
        },
        'sourceDonnee': {
          'id': this.sourceDonnee?.id,
        },
        'utilisateur': {
          'id': this.utilisateur?.id,
        }
      };

  @override
  String toString() {
    return 'Traduction{id: $id, libelle: $libelle, contenuTexte: $contenuTexte, contenuAudio: $contenuAudio, contenuAudioContentType: $contenuAudioContentType, type: $type, note: $note, etat: $etat, createdDate: $createdDate, langue: $langue, sourceDonnee: $sourceDonnee, utilisateur: $utilisateur}';
  }
}
