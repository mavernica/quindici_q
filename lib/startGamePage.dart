import 'package:flutter/material.dart';
import 'package:quindici_q/styleguide.dart';
import 'dart:math' as math;

import 'CategoryClass.dart';
import 'constants.dart';
import 'data.dart';
import 'chooseTeams.dart';
import 'homePageBackground.dart';
import 'myAppBar.dart';

class StartGamePage extends StatelessWidget {
  final PlanetInfo planetInfo;

  const StartGamePage({super.key, required this.planetInfo});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: const MyAppBarBack(),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
            child: Stack(children: [
          const HomePageBackground(),
          Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 260),
                    Text(
                      planetInfo.name,
                      style: categoryTitleStyle,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      'Solar System',
                      style: categorySubTitleStyle,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      planetInfo.description ?? '',
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 20,
                        color: contentTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, a, b) => ChooseTeams(),
                            ),
                          );
                        },
                        child: Container(
                            width: screenWidth,
                            height: screenHeight * 0.25,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0XFF182848),
                                    Color(0XFF4b6cb7),
                                  ]),
                            ),
                            child: Container(
                                width: screenWidth * 0.88,
                                height: (screenHeight * 0.25) * 0.88,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                      image: AssetImage("assets/Standard.jpg"),
                                      fit: BoxFit.cover),
                                ),
                                child: const Center(
                                    child: Text(
                                  "Standard",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 50,
                                  ),
                                )))
                        )),
                    Text(
                      planetInfo.name,
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 56,
                        color: primaryTextColor,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      'Solar System',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 31,
                        color: primaryTextColor,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      planetInfo.description ?? '',
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 20,
                        color: contentTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        width: screenWidth,
                        height: screenHeight * 0.3,
                        child: ListWheelScrollView.useDelegate(
                            itemExtent: 180,
                            diameterRatio: 2,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            childDelegate: ListWheelChildLoopingListDelegate(
                                children: List<Container>.generate(
                                    category.length,
                                    (index) => Container(
                                        width: screenWidth,
                                        height: screenHeight * 0.25,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Color((math.Random()
                                                                .nextDouble() *
                                                            0xFFFFFF)
                                                        .toInt())
                                                    .withOpacity(1.0),
                                                Color((math.Random()
                                                                .nextDouble() *
                                                            0xFFFFFF)
                                                        .toInt())
                                                    .withOpacity(1.0),
                                                Color((math.Random()
                                                                .nextDouble() *
                                                            0xFFFFFF)
                                                        .toInt())
                                                    .withOpacity(1.0),
                                              ]),
                                        ),
                                        child: Container(
                                            width: screenWidth * 0.88,
                                            height: screenHeight * 0.24,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      category[index].image),
                                                  fit: BoxFit.cover),
                                            ),
                                            child: Center(
                                                child: Text(
                                              category[index].title,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 50,
                                              ),
                                            )))))))),
                    const SizedBox(
                      height: 20,
                    ),
                  ])),
          Positioned(
            left: -24,
            child: Hero(
                tag: planetInfo.position,
                child: Image.asset(planetInfo.iconImage)),
          ),
          Positioned(
            top: 50,
            right: -24,
            child: Text(
              planetInfo.position.toString(),
              style: TextStyle(
                fontFamily: 'Avenir',
                fontSize: 247,
                color: primaryTextColor.withOpacity(0.3),
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ])));
  }
}
