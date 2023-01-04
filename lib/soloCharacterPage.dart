import 'package:flutter/material.dart';
import 'package:quindici_q/soloGamePage.dart';
import 'package:quindici_q/styleguide.dart';

import 'CharacterClass.dart';
import 'constants.dart';
import 'modeClass.dart';
import 'homePageBackground.dart';
import 'myAppBar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';


class SoloCharacterPage extends StatelessWidget {
  final Mode cardInfo;

  const SoloCharacterPage({super.key, required this.cardInfo});

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
                      cardInfo.insideTitle,
                      style: categoryTitleStyle,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      cardInfo.insideSubTitle,
                      style: categorySubTitleStyle,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      cardInfo.insideDescription,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: categoryDescriptionTitleStyle
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ListView.builder(
                        padding: const EdgeInsets.only(
                            bottom: kFloatingActionButtonMargin + 70),
                        //sennò aggiunge uno spazio in alto per qualche motivo
                        itemCount: characters.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                      child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (context, a, b) =>
                                                    SoloGamePage(character: characters[index]),
                                              ),
                                            );
                                          },
                                          child: Card(
                                            margin: const EdgeInsets.symmetric(vertical: 10),
                                            elevation: 10,
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15),
                                              side: const BorderSide(
                                                color: Color(0xff122c45),
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
                                                      child: Lottie.asset(characters[index].buttonImage,
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: DefaultTextStyle(
                                                    style: buttonCategoryTitleStyle,
                                                    child: Text(
                                                      characters[index].name,
                                                      style: buttonCategoryTitleStyle,
                                                    )
                                                  ),
                                                ),
                                              ]),
                                            ),
                                          ),))));
                        }),
                  ])),
          Positioned(
            left: -24,
            child: Hero(
                tag: cardInfo.title.toString(),
                child: Image.asset(cardInfo.iconImage)),
          ),
          Positioned(
            top: 50,
            right: -24,
            child: Text(
              cardInfo.position.toString(),
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
