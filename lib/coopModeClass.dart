
class CoopModeClass {
  List<Question> questionList = []; //elenco domande. Per sapere quella attuale questionList[index]
  List<Team> teams = [];
  int currentIndex = 0;

  CoopModeClass(team1, team2) {
    teams.add(team1);
    teams.add(team2);
  }
}

class Question {
  late String nome; //nome parola da indovinare
  late String categoria; // cosa, persona, luogo
  late String sottocategoria; // Storia, Cinema, Letteruatura...
  late List<dynamic> indizi; // ogni parola ha tante domande. Sono 16 domande fisse e 2 aiuti. Totale 18.
  late List<bool> questionsPressed; // mantengo un riferimento ad ogni domanda già fatta

  Question(
      {required this.nome,
        required this.categoria,
        required this.sottocategoria,
        required this.indizi,
        required this.questionsPressed});

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
        nome: map['nome'] ?? 'Default',
        categoria: map['categoria'] ?? 'DefaultCategory',
        sottocategoria: map['sottocategoria'] ?? 'DefaultCategory',
        indizi: map['indizi'] ?? {},
        questionsPressed: List.filled(18, false));
  }
}

class Team {

  late String name;
  int point = 0;
  int wordsCount = 0;
  List<String> wordsGuessed = [];
  late String image;

  Team(this.name, this.image);

  void addPoint(String word) {
    wordsCount += 1;
    point += 10;
    wordsGuessed.add(word);
  }
}


