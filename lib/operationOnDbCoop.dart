
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

List<PostCoop> transFromJsonCoop(String str) => List<PostCoop>.from(
    json.decode(str).map((x) => PostCoop.fromJson(x)));

String transToJsonCoop(List<PostCoop> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostCoop {
   String nome;
   String categoria;
   String sottocategoria;
   List indizi;
   List risposte;

  PostCoop({required this.nome, required this.categoria, required this.sottocategoria, required this.indizi, required this.risposte});

  factory PostCoop.fromJson(Map<String, dynamic> json) => PostCoop(
        nome: json['nome'],
        categoria: json["categoria"],
        sottocategoria:json["sottocategoria"],
        indizi: json["indizi"],
        risposte: json["risposte"],
    );

   Map<String, dynamic> toJson() => {
     "nome": nome,
     "categoria": categoria,
     "sottocategoria": sottocategoria,
     "indizi": indizi,
     "risposte": risposte,
   };
  }


class OperationOnDbCoop{
  var db = FirebaseFirestore.instance.collection("question");

  Future<void> readJsonAndUpload() async {
    final String response = await rootBundle.loadString('assets/prova.json');
    List<PostCoop> listOfJson = transFromJsonCoop(response);

    for (var e in listOfJson) {
      db.add({
        "nome": e.nome,
        "categoria": e.categoria,
        "sottocategoria": e.sottocategoria,
        "indizi": e.indizi,
        "risposte": e.risposte,
      });
      print("Element ${e.nome} uploaded");
    }
    print("Loaded ${listOfJson.length}");
    }

  Future<void> deleteAllData() async {
    final instance = FirebaseFirestore.instance;
    final batch = instance.batch();
    var collection = instance.collection('question');
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
    print("All element removed: ${snapshots.docs.length}");
  }

 }