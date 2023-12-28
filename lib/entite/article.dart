// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

class Article {
  String code;
  String lib;
  double qte;
  String? typevente;
  String dispo;
  get getCode => this.code;

 set setCode( code) => this.code = code;

  get getLib => this.lib;

 set setLib( lib) => this.lib = lib;

  get getQte => this.qte;

 set setQte( qte) => this.qte = qte;

  get getTypevente => this.typevente;

 set setTypevente( typevente) => this.typevente = typevente;

  get getDispo => this.dispo;

 set setDispo(String dispo) => this.dispo = dispo;

  Article({
     this.code="",
     this.lib="",
     this.qte=0.0,
     this.typevente,
     this.dispo="",
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'libelle': lib,
      'qte': qte,
      'typedevente': typevente,
      'dispo': dispo,
    };
  }

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      code: map['code'] as String,
      lib: map['lib'] as String,
      qte: map['qte'] as double,
      typevente: map['typevente'],
      dispo: map['dispo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Article.fromJson(String source) => Article.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Article(code: $code, lib: $lib, qte: $qte, typevente: $typevente, dispo: $dispo)';
  }



}
