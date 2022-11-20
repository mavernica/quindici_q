
class StandardModeClass {
  List<Question> questionList = []; //elenco domande. Per sapere quella attuale questionList[index]
  List<Team> teams = [];
  int currentIndex = 0;

  StandardModeClass(team1, team2) {
    teams.add(team1);
    teams.add(team2);
  }
}

class Question {
  late String name; //nome parola da indovinare
  late String category; // cosa, persona, luogo
  late String subCategory; // Storia, Cinema, Letteruatura...
  late String wikiPage; //pagina wikipedia della parola da indovinare
  late List<dynamic> questions; // ogni parola ha tante domande. Sono 16 domande fisse e 2 aiuti. Totale 18.
  late List<bool> questionsPressed; // mantengo un riferimento ad ogni domanda già fatta

  Question(
      {required this.name,
        required this.category,
        required this.subCategory,
        required this.wikiPage,
        required this.questions,
        required this.questionsPressed});

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
        name: map['name'] ?? 'Default',
        category: map['category'] ?? 'DefaultCategory',
        subCategory: map['subCategory'] ?? 'DefaultCategory',
        wikiPage: map['wikiPage'] ?? 'DefaultWikiPage',
        questions: map['questions'] ?? {},
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


