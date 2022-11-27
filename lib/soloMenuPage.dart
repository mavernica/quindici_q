import 'package:flutter/material.dart';
import 'package:quindici_q/soloMode.dart';
import 'package:quindici_q/styleguide.dart';
import 'dart:math' as math;

import 'CategoryClass.dart';
import 'constants.dart';
import 'modeClass.dart';
import 'chooseTeams.dart';
import 'homePageBackground.dart';
import 'myAppBar.dart';

class SoloMenuPage extends StatelessWidget {
  final Mode planetInfo;

  const SoloMenuPage({super.key, required this.planetInfo});

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
                        const Text(
                          "Solitaria",
                          style: categoryTitleStyle,
                          textAlign: TextAlign.left,
                        ),
                        const Text(
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
                                  pageBuilder: (context, a, b) => SoloMode(),
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
                                          "Solo",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 50,
                                          ),
                                        )))
                            )),
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
