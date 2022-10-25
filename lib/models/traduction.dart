import 'package:flutter/services.dart';
import 'package:langtech_moore_mobile/enum/etat.dart';
import 'package:langtech_moore_mobile/enum/type_traduction.dart';
import 'package:langtech_moore_mobile/models/langue.dart';

class Traduction {
  int? id;
  String? libelle;
  String? contenuTexte;
  ByteData? contenuAudio;
  String? contenuAudioContentType;
  TypeTraduction? type;
  int? note;
  Etat? etat;
  Langue? langue;

  Traduction({
    this.id,
    this.libelle,
    this.contenuTexte,
    this.contenuAudio,
    this.contenuAudioContentType,
    this.type,
    this.note,
    this.etat,
    this.langue,
  });

  Traduction.fromJson(Map<String, dynamic> json) {
    this.id = json['id'] as int;
    this.libelle = json['libelle'];
    this.contenuTexte = json['contenuTexte'];
    this.contenuAudio = json['contenuAudio'];
    this.contenuAudioContentType = json['contenuAudioContentType'];
    this.type = json['type'] as TypeTraduction;
    this.note = json['note'] as int;
    this.etat = json['etat'] as Etat;
    this.langue = Langue.fromJson(json[json['langue']]);
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
          'id': this.langue!.id,
        }
      };
}
