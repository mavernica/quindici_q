
class SoloQuestion {
  late String nome; //nome parola da indovinare
  late String categoria; // cosa, persona, luogo
  late String sottocategoria; // Storia, Cinema, Letteruatura...
  late List<dynamic> indizi;
  late List<dynamic> risposteBot;
  late List<dynamic> risposteEsatte;


  SoloQuestion(
      {required this.nome,
        required this.categoria,
        required this.sottocategoria,
        required this.indizi,
        required this.risposteBot,
        required this.risposteEsatte,
       });

  factory SoloQuestion.fromMap(Map<String, dynamic> map) {
    return SoloQuestion(
        nome: map['nome'] ?? 'Default',
        categoria: map['categoria'] ?? 'DefaultCategory',
        sottocategoria: map['sottocategoria'] ?? 'DefaultCategory',
        indizi: map['indizi'] ?? {},
        risposteBot: map['risposte'] ?? {},
        risposteEsatte: map['risposte esatte'] ?? {});
  }
}



