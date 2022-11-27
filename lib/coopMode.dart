import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quindici_q/filterView.dart';
import 'package:quindici_q/questionGenerator.dart';
import 'package:quindici_q/coopModeClass.dart';
import 'pointSummary.dart';
import 'showPointIncreased.dart';
import 'constants.dart';
import 'globalView.dart';
import 'myAppBar.dart';

class CoopMode extends StatefulWidget {
  final String team1;
  final String team2;
  final String team1Image;
  final String team2Image;

  const CoopMode(
      {super.key,
      required this.team1,
      required this.team2,
      required this.team1Image,
      required this.team2Image});

  @override
  State<CoopMode> createState() => _CoopModeState();
}

class _CoopModeState extends State<CoopMode> {
  PageController? controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    CoopModeClass game = CoopModeClass(
        Team(widget.team1, widget.team1Image),
        Team(widget.team2, widget.team2Image));

    controller = PageController(initialPage: game.currentIndex);

    return Scaffold(
        appBar: const MyAppBar(),
        floatingActionButton: floatingButtons(game),
        bottomNavigationBar: myBottomNavBar(context, game),
        extendBodyBehindAppBar: true,
        body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance.collection("question").get(),
            builder: (BuildContext context, querySnapshot) {
              if (querySnapshot.hasError) {
                if (kDebugMode) {
                  print("Something went wrong in fetch data from DB...");
                }
              }

              if (querySnapshot.hasData) {
                if (kDebugMode) {
                  print("Data fetched from DB");
                }
                game.questionList = querySnapshot.data!.docs
                    .map(
                      (doc) => Question.fromMap(doc.data()),
                    )
                    .toList();

                return PageView.builder(
                  controller: controller,
                  itemCount: game.questionList.length,
                  itemBuilder: (context, index) {
                    return createPage(context,
                        game.questionList[index]); //è una singola pagina
                  },
                  onPageChanged: (index) {
                    game.currentIndex = index;
                  },
                );
              }
              return AlertDialog(
                backgroundColor: Colors.transparent,
                content: Center(
                  child: Image.asset(
                    'assets/pacman.gif', // Put your gif into the assets folder
                    width: 100,
                  ),
                ),
              );
            }));
  }

  Widget createPage(BuildContext context, Question singleQuestion) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(
                        height:
                            50 //altezza dall'alto. Obbligatoria se incorporti il body dentro l'app bar
                        ),
                    Text(
                      singleQuestion.nome,
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 56,
                        color: primaryTextColor,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ListView.builder(
                      padding: const EdgeInsets.all(
                          0), //sennò aggiunge uno spazio in alto per qualche motivo
                      itemCount: singleQuestion.indizi.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        //primo bottone
                        return ButtonGenerator(singleQuestion,
                            index); //15 domande e passo indice per segnare quelle scelte
                      },
                    ),
                  ],
                ))));
  }

  Widget myBottomNavBar(BuildContext context, CoopModeClass game) {
    return Row(
      children: [
        Material(
          color: const Color(0xffff8989),
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                // color is applied to main screen when modal bottom screen is displayed
                //background color for modal bottom screen
                backgroundColor: Colors.blue,
                //elevates modal bottom screen
                elevation: 10,
                // gives rounded corner to modal bottom screen
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                builder: (BuildContext context) {
                  return pointSummary(context, game.teams);
                },
              );
            },
            child: const SizedBox(
              height: kToolbarHeight,
              width: 130,
              child: Center(
                child: Text(
                  'Riepilogo punti',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Material(
            color: const Color(0xffff8906),
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  // color is applied to main screen when modal bottom screen is displayed
                  //background color for modal bottom screen
                  backgroundColor: Colors.deepOrangeAccent,
                  //elevates modal bottom screen
                  elevation: 10,
                  // gives rounded corner to modal bottom screen
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  builder: (BuildContext context) {
                    // UDE : SizedBox instead of Container for whitespaces
                    return SizedBox(
                        height: 250,
                        child: Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  "Chi ha indovinato?",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                game.teams[0].addPoint(game
                                                    .questionList[
                                                        game.currentIndex]
                                                    .nome);
                                                showPointIncreased(context,
                                                    game.teams); //teams
                                              },
                                              child: Container(
                                                  width: 180,
                                                  height: 180,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    image: DecorationImage(
                                                        image: AssetImage(game
                                                            .teams[0].image),
                                                        fit: BoxFit.cover),
                                                  ),
                                                  child: Center(
                                                      child: Text(
                                                    game.teams[0].name,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                    ),
                                                  )))),
                                          InkWell(
                                              onTap: () {
                                                game.teams[1].addPoint(game
                                                    .questionList[
                                                        game.currentIndex]
                                                    .nome);
                                                showPointIncreased(context,
                                                    game.teams); //teams
                                              },
                                              child: Container(
                                                  width: 180,
                                                  height: 180,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    image: DecorationImage(
                                                        image: AssetImage(game
                                                            .teams[1].image),
                                                        fit: BoxFit.cover),
                                                  ),
                                                  child: Center(
                                                      child: Text(
                                                    game.teams[1].name,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                    ),
                                                  ))))
                                        ])),
                              ]),
                        ));
                  },
                );
              },
              child: const SizedBox(
                height: kToolbarHeight,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Parola indovinata',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget floatingButtons(CoopModeClass game) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
      SizedBox(
          height: 50.0,
          width: 50.0,
          child: FittedBox(
              child: FloatingActionButton(
            heroTag: "btn1",
            backgroundColor: Colors.blueAccent,
            elevation: 2,
            foregroundColor: Colors.black,
            onPressed: () {
              List<String> words = [];
              for (var item in game.questionList) {
                words.add(item.nome);
              }
              GlobalView.displayDialogSelectWordWithCallBack(context, words).then((index) {
                if (index != null) {
                  controller?.jumpToPage(index);
                }
              });
            },
            child: const Icon(Icons.view_carousel),
          ))),
      const SizedBox(
        width: 10,
      ),
      SizedBox(
          height: 50.0,
          width: 50.0,
          child: FittedBox(
            child: FloatingActionButton(
              heroTag: "btn2",
              backgroundColor: Colors.blueAccent,
              elevation: 2,
              foregroundColor: Colors.black,
              onPressed: () {
                //filterView.displayDialogSelectFilterWithCallBack(context);
                //game.questionList.sort((a, b) => a.name.compareTo(b.name));
                //controller?.notifyListeners();
              },
              child: const Icon(Icons.sort),
            ),
          ))
    ]);
  }
}
