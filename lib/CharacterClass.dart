
class CharacterClass {
  final String name;
  final int minTimeToGuess;
  final int maxTimeToGuess;
  final List<String> specialResponses;
  final String mainCategory;
  final String buttonImage;

  CharacterClass({
    required this.name,
    required this.minTimeToGuess,
    required this.maxTimeToGuess,
    required this.specialResponses,
    required this.mainCategory,
    required this.buttonImage,
  });
  
}

List<CharacterClass> characters = [
  CharacterClass(name: "Classic", minTimeToGuess: 10, maxTimeToGuess: 20, specialResponses:[], mainCategory: "storia", buttonImage: "assets/waves/classic.json"),   //tra 10 e 20
  CharacterClass(name: "Ghandi", minTimeToGuess: 12, maxTimeToGuess: 16, specialResponses:[], mainCategory: "storia", buttonImage: "assets/waves/b1.json"),   //tra 12 e 16
  CharacterClass(name: "Aristotele", minTimeToGuess: 8, maxTimeToGuess: 12, specialResponses:[], mainCategory: "storia", buttonImage: "assets/waves/b2.json"), //tra 8 e 12
  CharacterClass(name: "Darwin", minTimeToGuess: 4, maxTimeToGuess: 8, specialResponses:[], mainCategory: "storia", buttonImage: "assets/waves/b3.json"), //tra 4 e 8
  CharacterClass(name: "Tom Brady", minTimeToGuess: 1, maxTimeToGuess: 16, specialResponses:[], mainCategory: "sport", buttonImage: "assets/waves/blu1.json"), //tra 12 e 16
  CharacterClass(name: "Neymar", minTimeToGuess: 1, maxTimeToGuess: 12, specialResponses:[], mainCategory: "sport", buttonImage: "assets/waves/blu2.json"), //tra 8 e 12
  CharacterClass(name: "Tiger Woods	", minTimeToGuess: 1, maxTimeToGuess: 8, specialResponses:[], mainCategory: "sport", buttonImage: "assets/waves/blu3.json"), //tra 4 e 8
];