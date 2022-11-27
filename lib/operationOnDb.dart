
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

List<Post> transFromJson(String str) => List<Post>.from(
    json.decode(str).map((x) => Post.fromJson(x)));

String transToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
   String nome;
   String categoria;
   String sottocategoria;
   List indizi;
   List risposte;

  Post({required this.nome, required this.categoria, required this.sottocategoria, required this.indizi, required this.risposte});

  factory Post.fromJson(Map<String, dynamic> json) => Post(
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


class OperationOnDb{
  var db = FirebaseFirestore.instance.collection("question");

  Future<void> readJsonAndUpload() async {
    final String response = await rootBundle.loadString('assets/prova.json');
    List<Post> listOfJson = transFromJson(response);

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
