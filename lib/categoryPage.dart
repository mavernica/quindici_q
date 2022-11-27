import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:quindici_q/coopMenuPage.dart';
import 'package:quindici_q/styleguide.dart';
import 'modeClass.dart';
import 'homePageBackground.dart';
import 'myAppBar.dart';

class CategoryPage extends StatelessWidget {
  final Mode cardInfo;

  const CategoryPage({super.key, required this.cardInfo});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const MyAppBarBack(),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const HomePageBackground(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 260),
                  Text(
                    cardInfo.name,
                    style: categoryTitleStyle,
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    cardInfo.subName,
                    style: categorySubTitleStyle,
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    cardInfo.description ?? '',
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: categoryTextStyle
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, cardInfo.page);
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      elevation: 10,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: const BorderSide(
                          color: Color(0xFF414C6B),
                          width: 6,
                        ),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        height: 100,
                        width: screenWidth,
                        child: DefaultTextStyle(
                          style: buttonCategoryTitleStyle,
                          child: AnimatedTextKit(
                              animatedTexts: [
                                TypewriterAnimatedText('Pronto a cominciare?'),
                                TypewriterAnimatedText("Sarai all'altezza?",
                                    cursor: '|'),
                                TypewriterAnimatedText('Iniziamo...',
                                    cursor: '|'),
                              ],
                              isRepeatingAnimation: true,
                              totalRepeatCount: 2,
                              onTap: () {
                                Navigator.pushNamed(context, cardInfo.page);
                              }),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    elevation: 10,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(
                        color: Color(0xFF414C6B),
                        width: 6,
                      ),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        Navigator.pushNamed(context, cardInfo.instruction);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        height: 100,
                        width: screenWidth,
                        child: const DefaultTextStyle(
                            style: buttonCategoryTitleStyle,
                            child: Text("Istruzioni")),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              right: -64,
              child: Hero(
                  tag: cardInfo.position,
                  child: Image.asset(cardInfo.iconImage)),
            ),
            Positioned(
              top: 50,
              left: 32,
              child: Text(
                cardInfo.position.toString(),
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: 247,
                  color: const Color(0xFF414C6B).withOpacity(0.3),
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
