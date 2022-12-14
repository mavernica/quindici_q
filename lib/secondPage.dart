import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quindici_q/styleguide.dart';
import 'modeClass.dart';
import 'homePageBackground.dart';
import 'myAppBar.dart';

class SecondPage extends StatelessWidget {
  final Mode singleCard;

  const SecondPage({super.key, required this.singleCard});

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
                  const SizedBox(height: 300),
                  Text(
                    singleCard.title,
                    style: categoryTitleStyle,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    singleCard.subTitle.replaceAll("\n", " "),
                    style: categorySubTitleStyle,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 8),
                  Text(singleCard.description, textAlign: TextAlign.left, style: categoryDescriptionTitleStyle),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, singleCard.page);
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      elevation: 10,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: const BorderSide(
                          color: spButtonBgColor,
                          width: 6,
                        ),
                      ),
                      child: SizedBox(
                        width: screenWidth,
                        height: 100,
                        child: Stack(children: <Widget>[
                          SizedBox.expand(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: Lottie.asset('assets/waves/rightUpWave.json',
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: DefaultTextStyle(
                              style: buttonCategoryTitleStyle,
                              child: AnimatedTextKit(
                                  animatedTexts: [
                                    TypewriterAnimatedText(
                                        'Pronto?'),
                                    TypewriterAnimatedText('Iniziamo...',
                                        cursor: '|'),
                                  ],
                                  isRepeatingAnimation: true,
                                  totalRepeatCount: 1,
                                  onTap: () {
                                    Navigator.pushNamed(context, singleCard.page);
                                  }),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, singleCard.instruction);
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    elevation: 10,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(
                        color: spButtonBgColor,
                        width: 6,
                      ),
                    ),
                    child: SizedBox(
                      width: screenWidth * 0.8,
                      height: 80,
                      child: Stack(children: <Widget>[
                        SizedBox.expand(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: Lottie.asset('assets/waves/leftDownWave.json',
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: DefaultTextStyle(
                            style: buttonCategoryTitleStyle,
                            child: AnimatedTextKit(
                                animatedTexts: [
                                  TypewriterAnimatedText(
                                      'Serve aiuto?'),
                                  TypewriterAnimatedText("Istruzioni",
                                      cursor: '|'),
                                ],
                                isRepeatingAnimation: true,
                                totalRepeatCount: 1,
                                onTap: () {
                                  Navigator.pushNamed(context, singleCard.instruction);
                                }),
                          ),
                        ),
                      ]),
                    ),
                  ),
              ),
              ),
                ],
              ),
            ),
            Positioned(
              right: -64,
              child: Hero(
                  tag: singleCard.title.toString(),
                  child: Image.asset(singleCard.iconImage)),
            ),
            Positioned(
              top: 50,
              left: 32,
              child: Text(
                singleCard.position.toString(),
                style: const TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: 247,
                  color: Colors.black12,
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
