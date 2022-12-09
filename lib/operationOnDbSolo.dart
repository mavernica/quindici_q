import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List<PostSolo> transFromJsonSolo(String str) => List<PostSolo>.from(
    json.decode(str).map((x) => PostSolo.fromJson(x)));

String transToJsonSolo(List<PostSolo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostSolo {
  String nome;
  String categoria;
  String sottocategoria;
  List indizi;
  List risposte;
  List riposteEsatte;

  PostSolo({required this.nome, required this.categoria, required this.sottocategoria, required this.indizi, required this.risposte, required this.riposteEsatte});

  factory PostSolo.fromJson(Map<String, dynamic> json) => PostSolo(
    nome: json['nome'],
    categoria: json["categoria"],
    sottocategoria:json["sottocategoria"],
    indizi: json["indizi"],
    risposte: json["risposte"],
    riposteEsatte: json["risposte esatte"]
  );

  Map<String, dynamic> toJson() => {
    "nome": nome,
    "categoria": categoria,
    "sottocategoria": sottocategoria,
    "indizi": indizi,
    "risposte": risposte,
    "risposte esatte": riposteEsatte
  };
}


class OperationOnDbSolo{
  var db = FirebaseFirestore.instance.collection("questionSolo");

  Future<void> readJsonAndUpload() async {

    final String response = await rootBundle.loadString('assets/SoloImport.json');
    List<PostSolo> listOfJson = transFromJsonSolo(response);
    print("NUMERO DI ELEMENTI ${listOfJson.length}");

    for (var e in listOfJson) {
      db.add({
        "nome": e.nome,
        "categoria": e.categoria,
        "sottocategoria": e.sottocategoria,
        "indizi": e.indizi,
        "risposte": e.risposte,
        "risposte esatte": e.riposteEsatte
      });
      print("Element ${e.nome} uploaded");
    }
    print("Loaded ${listOfJson.length}");
  }

  Future<void> deleteAllData() async {
    final instance = FirebaseFirestore.instance;
    final batch = instance.batch();
    var collection = instance.collection('questionSolo');
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
    print("All element removed: ${snapshots.docs.length}");
  }

}
