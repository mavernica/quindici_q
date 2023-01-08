class Mode {
  final int position; //prima pagina

  final String title;
  final String subTitle;
  final String description;
  final String page;
  final String instruction;
  final String iconImage;

  final String insideTitle; //pagina più profonda
  final String insideSubTitle;
  final String insideDescription;

  Mode(this.position,
      {
      required this.title,
      required this.subTitle,
      required this.iconImage,
      required this.description,
      required this.insideTitle,
      required this.insideSubTitle,
      required this.insideDescription,
      required this.page,
      required this.instruction});
}

List<Mode> modeList = [
  Mode(
     1,
      title: 'Solitaria',
      subTitle: 'Single\nplayer',
      description:
          "In questa modalità potrai giocare con il computer e cercare di batterlo. Avrai la possibilità di scontrarti contro vari avversarsi celebri"
          "ma attenzione che alcuni di loro si riveleranno più ostici del previsto da battere.",
      page: '/solo',
      instruction: '/instructionCoop',
      iconImage: 'assets/planets/venus.png',
      insideTitle: "Personaggi",
      insideSubTitle: "Scegli la tua nemesi",
      insideDescription:
          "Scegli il giocatore contro cui ti scontrerai. Attenzione che la difficioltà aumenterà a secondo del personaggio."),
  Mode(
    2,
    title: 'Cooperativa',
    subTitle: 'Gioco di\nsquadra',
    description:
    "Zipping around the sun in only 88 days, Mercury is the closest planets to the sun, and it's also the smallest, only a little bit larger than Earth's moon. Because its so close to the sun (about two-fifths the distance between Earth and the sun), Mercury experiences dramatic changes in its day and night temperatures: Day temperatures can reach a scorching 840  F (450 C), which is hot enough to melt lead. Meanwhile on the night side, temperatures drop to minus 290 F (minus 180 C).",
    iconImage: 'assets/planets/mercury.png',
    page: '/standard',
    instruction: '/instructionSolo',
    insideTitle: "Personaggi",
    insideSubTitle: "Scegli la tua nemesi",
    insideDescription:
    "Zipping around the sun in only 88 days, Mercury is the closest planets to the sun, and it's also the smallest, only a little bit larger than Earth's moon. Because its so close to the sun (about two-fifths the distance between Earth and the sun), Mercury experiences dramatic changes in its day and night temperatures: Day temperatures can reach a scorching 840  F (450 C), which is hot enough to melt lead. Meanwhile on the night side, temperatures drop to minus 290 F (minus 180 C).",
  ),

  Mode(3,
      title: 'Earth',
      subTitle: 'a squadre',
      page: '/second',
      instruction: '/instructionSolo',
      iconImage: 'assets/planets/earth.png',
      description:
          "The third planets from the sun, Earth is a waterworld, with two-thirds of the planets covered by ocean. It's the only world known to harbor life. Earth's atmosphere is rich in nitrogen and oxygen. Earth's surface rotates about its axis at 1,532 feet per second (467 meters per second) — slightly more than 1,000 mph (1,600 kph) — at the equator. The planets zips around the sun at more than 18 miles per second (29 km per second).",
      insideTitle: "Personaggi",
      insideSubTitle: "Scegli la tua nemesi",
      insideDescription:
      "Scegli il giocatore contro cui ti scontrerai. Attenzione che la difficioltà aumenterà a secondo del personaggio."),
  Mode(4,
      title: 'Mars',
      subTitle: 'a squadre',
      page: '/second',
      instruction: '/instructionSolo',
      iconImage: 'assets/planets/mars.png',
      description:
          "The fourth planets from the sun is Mars, and it's a cold, desert-like place covered in dust. This dust is made of iron oxides, giving the planets its iconic red hue. Mars shares similarities with Earth: It is rocky, has mountains, valleys and canyons, and storm systems ranging from localized tornado-like dust devils to planets-engulfing dust storms. ",
      insideTitle: "Personaggi",
      insideSubTitle: "Scegli la tua nemesi",
      insideDescription:
      "Scegli il giocatore contro cui ti scontrerai. Attenzione che la difficioltà aumenterà a secondo del personaggio."),
  Mode(5,
      title: 'Jupiter',
      subTitle: 'a squadre',
      page: '/second',
      instruction: '/instructionSolo',
      iconImage: 'assets/planets/jupiter.png',
      description:
          "The fifth planets from the sun, Jupiter is a giant gas world that is the most massive planets in our solar system — more than twice as massive as all the other planets combined, according to NASA. Its swirling clouds are colorful due to different types of trace gases. And a major feature in its swirling clouds is the Great Red Spot, a giant storm more than 10,000 miles wide. It has raged at more than 400 mph for the last 150 years, at least. Jupiter has a strong magnetic field, and with 75 moons, it looks a bit like a miniature solar system.",
      insideTitle: "Personaggi",
      insideSubTitle: "Scegli la tua nemesi",
      insideDescription:
      "Scegli il giocatore contro cui ti scontrerai. Attenzione che la difficioltà aumenterà a secondo del personaggio."),

];
