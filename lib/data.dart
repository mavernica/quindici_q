class PlanetInfo {
  final int position;
  final String name;
  final String subName;
  final String page;
  final String iconImage;
  final String description;

  PlanetInfo(
    this.position, {
    required this.name,
    required this.subName,
    required this.iconImage,
    required this.description,
    required this.page
  });
}

List<PlanetInfo> planets = [
  PlanetInfo(1,
      name: 'Gioco',
      subName: 'Squadre',
      iconImage: 'assets/planets/mercury.png',
      page: '/second',
      description:
          "Zipping around the sun in only 88 days, Mercury is the closest planets to the sun, and it's also the smallest, only a little bit larger than Earth's moon. Because its so close to the sun (about two-fifths the distance between Earth and the sun), Mercury experiences dramatic changes in its day and night temperatures: Day temperatures can reach a scorching 840  F (450 C), which is hot enough to melt lead. Meanwhile on the night side, temperatures drop to minus 290 F (minus 180 C).",
      ),
  PlanetInfo(2,
      name: 'Venus',
      subName: 'a squadre',
      page: '/second',
      iconImage: 'assets/planets/venus.png',
      description:
          "The second planets from the sun, Venus is Earth's twin in size. Radar images beneath its atmosphere reveal that its surface has various mountains and volcanoes. But beyond that, the two planets couldn't be more different. Because of its thick, toxic atmosphere that's made of sulfuric acid clouds, Venus is an extreme example of the greenhouse effect. It's scorching-hot, even hotter than Mercury. The average temperature on Venus' surface is 900 F (465 C). At 92 bar, the pressure at the surface would crush and kill you. And oddly, Venus spins slowly from east to west, the opposite direction of most of the other planets.",
      ),
  PlanetInfo(3,
      name: 'Earth',
      subName: 'a squadre',
      page: '/second',
      iconImage: 'assets/planets/earth.png',
      description:
          "The third planets from the sun, Earth is a waterworld, with two-thirds of the planets covered by ocean. It's the only world known to harbor life. Earth's atmosphere is rich in nitrogen and oxygen. Earth's surface rotates about its axis at 1,532 feet per second (467 meters per second) — slightly more than 1,000 mph (1,600 kph) — at the equator. The planets zips around the sun at more than 18 miles per second (29 km per second).",
      ),
  PlanetInfo(4,
      name: 'Mars',
      subName: 'a squadre',
      page: '/second',
      iconImage: 'assets/planets/mars.png',
      description:
          "The fourth planets from the sun is Mars, and it's a cold, desert-like place covered in dust. This dust is made of iron oxides, giving the planets its iconic red hue. Mars shares similarities with Earth: It is rocky, has mountains, valleys and canyons, and storm systems ranging from localized tornado-like dust devils to planets-engulfing dust storms. ",
      ),
  PlanetInfo(5,
      name: 'Jupiter',
      subName: 'a squadre',
      page: '/second',
      iconImage: 'assets/planets/jupiter.png',
      description:
          "The fifth planets from the sun, Jupiter is a giant gas world that is the most massive planets in our solar system — more than twice as massive as all the other planets combined, according to NASA. Its swirling clouds are colorful due to different types of trace gases. And a major feature in its swirling clouds is the Great Red Spot, a giant storm more than 10,000 miles wide. It has raged at more than 400 mph for the last 150 years, at least. Jupiter has a strong magnetic field, and with 75 moons, it looks a bit like a miniature solar system.",
      )
];
