import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quindici_q/soloModelClass.dart';
import 'package:quindici_q/soloUserAndBotResponses.dart';
import 'package:quindici_q/soloUserCanResponseDialog.dart';
import 'package:quindici_q/soloUserMustResponseDialog.dart';
import 'ButtonGeneratorSolo.dart';
import 'myAppBar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:neon_circular_timer/neon_circular_timer.dart';
import 'package:wave/wave.dart';
import 'package:wave/config.dart';


class SoloMode extends StatefulWidget {
  const SoloMode({super.key});

  @override
  State<SoloMode> createState() => _SoloModeState();
}

class _SoloModeState extends State<SoloMode> {
  Random random = Random();
  var ctime;

  List<SoloQuestion> questionsGetFromDb = [];

  late SoloQuestion currentQuestion; //elemento che viene visualizzato
  late int currentClueIndex;

  late List<String> listOfClue; //lista di indizi in forma di stringa
  late List<int>
      listOfCluesUsed; //lista di indizi già presenti in forma di interi
  late int botWinCounter;

  late List<String> userResponses = []; //risposte utente

  late Timer timer;
  int timeRemaining = 60;
  bool menuIsOpen = false;

  late TextEditingController userCanResponseController;
  late TextEditingController userMustResponseController;
  CountDownController timerController = CountDownController();



  static const _backgroundColor = Colors.white;

  static const _colors = [
    Color(0xff061993),
    Color(0xff0C3BAA),
    Color(0xff135CC5),
    Color(0xff1973D1),
  ];

  static const _durations = [
    27000, 11000, 5000, 12000
  ];

  static const _heightPercentages = [
    0.75, 0.76, 0.78, 0.80
  ];

  @override
  void initState() {
    super.initState();
  }

  void createNewQuestion() {
    currentClueIndex = 0;
    int randomQuestion = random.nextInt(29) + 0; // from right to sum of them -1
    currentQuestion = questionsGetFromDb[randomQuestion];
    currentQuestion.risposteEsatte = currentQuestion.risposteEsatte
        .map((word) => word.toLowerCase())
        .toList();
    listOfClue = [];
    listOfCluesUsed = [];
    userResponses = [];
    userCanResponseController = TextEditingController();
    userMustResponseController = TextEditingController();
    botWinCounter = random.nextInt(5) + 8;
  }

  /// genera un nuovo indizio utilizzando un valore casuale compreso tra 0 e 20
  void addNewClue() {
    int randomClue = random.nextInt(14) + 0; // from right to sum of them -1
    while (listOfCluesUsed.contains(randomClue)) {
      //finchè il numero random è giù uscito ne generi uno nuovo
      randomClue = random.nextInt(14) + 0;
    }
    listOfCluesUsed.add(randomClue);
    listOfClue.add(currentQuestion.indizi[randomClue]);
    currentClueIndex = randomClue;
    startTimer(); //faccio partire il timer
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      WaveWidget(
        config: CustomConfig(
          colors: _colors,
          durations: _durations,
          heightPercentages: _heightPercentages,
        ),
        backgroundColor: _backgroundColor,
        size: Size(double.infinity, double.infinity),
        waveAmplitude: 40,
      ),
      Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: resultNavBar(context),
          extendBodyBehindAppBar: true,
          floatingActionButton: circleTimer(),
          appBar: const MyAppBarBack(),
          body: WillPopScope(
              onWillPop: () {
                DateTime now = DateTime.now();
                if (ctime == null ||
                    now.difference(ctime) > const Duration(seconds: 2)) {
                  //add duration of press gap
                  ctime = now;
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                          'Premi di nuovo per uscire, perderai la partita in corso'))); //scaffold message, you can show Toast message too.
                  return Future.value(false);
                }
                return Future.value(true);
              },
              child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  future: FirebaseFirestore.instance
                      .collection("questionSolo")
                      .get(),
                  builder: (BuildContext context, querySnapshot) {
                    if (questionsGetFromDb.isNotEmpty) {
                      return newPage(context);
                    } else {
                      if (querySnapshot.hasError) {
                        if (kDebugMode) {
                          print("Something went wrong in fetch data from DB");
                        }
                      }

                      if (querySnapshot.hasData) {
                        //not enter db when refreshing
                        if (kDebugMode) {
                          print("Data fetched from DB");
                        }
                        questionsGetFromDb = querySnapshot.data!.docs
                            .map(
                              (doc) => SoloQuestion.fromMap(doc.data()),
                            )
                            .toList();

                        createNewQuestion(); //scelgo una domanda casuala dal pool di domande ottenuto
                        addNewClue(); //aggiungo un nuovo indizio da visualizzare

                        return newPage(context); //è una singola pagina
                      }
                      return AlertDialog(
                        backgroundColor: Colors.transparent,
                        content: Center(
                          child: Image.asset(
                            'assets/pacman.gif',
                            // Put your gif into the assets folder
                            width: 100,
                          ),
                        ),
                      );
                    }
                  })))
    ]);
  }

  Widget newPage(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(
                    height:
                        50 //altezza dall'alto. Obbligatoria se incorporti il body dentro l'app bar
                    ),
                const Text(
                  "???",
                  style: TextStyle(
                    fontFamily: 'ModernSans',
                    fontSize: 56,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 10,
                ),
                ListView.builder(
                  padding: const EdgeInsets.only(
                      bottom: kFloatingActionButtonMargin + 70),
                  //sennò aggiunge uno spazio in alto per qualche motivo
                  itemCount: listOfClue.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                                child: ButtonGeneratorSolo(listOfClue,
                                    index)))); //15 domande e passo indice per impostare l'indizio
                  },
                ),
              ],
            )));
  }

  Widget resultNavBar(BuildContext context) {
    return Row(
      children: [
        Material(
          color: Colors.cyan,
          child: InkWell(
            onTap: () {
              menuIsOpen = true;
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                elevation: 10,
                shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25.0)),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                builder: (BuildContext context) {
                  return soloUserAndBotResponses(context, userResponses,
                      currentClueIndex, currentQuestion.risposteBot);
                },
              ).then((value) => {menuIsOpen = false});
            },
            child: const SizedBox(
              height: kToolbarHeight,
              width: 130,
              child: Center(
                child: Text(
                  'Riepilogo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'ModernSans',
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Material(
            color: Colors.blueAccent,
            child: InkWell(
              onTap: () {
                menuIsOpen = true;
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    elevation: 10,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25.0)),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    builder: (BuildContext context) {
                      return soloUserCanResponseDialog(
                          context, userCanResponseController);
                    }).then((value) => {
                      if (value == null)
                        {
                          menuIsOpen = false

                          ///l'utente ha chiuso la finestra
                        }
                      else
                        {
                          checkResponse(value)

                          ///ha passato o risposto
                        }
                    });
              },
              child: const SizedBox(
                height: kToolbarHeight, //altezza bottone in bassi
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Prova a indovinare',
                    style: TextStyle(
                      fontFamily: 'ModernSans',
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
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

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timeRemaining = 60;
    menuIsOpen = false;
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (timeRemaining == 0) {
          setState(() {
            timer.cancel();
            if (menuIsOpen) {
              Navigator.pop(context);
            }
            openMenuNotClosable();
          });
        } else {
          setState(() {
            timeRemaining--;
          });
        }
      },
    );
  }

  cancelTimer() {
    timer.cancel();
    timeRemaining = 0;
  }

  Widget circleTimer() {
    return SizedBox(
        height: 80.0,
        width: 80.0,
        child: FittedBox(
            child: FloatingActionButton(
          heroTag: "btn2",
          backgroundColor: Colors.red,
          elevation: 2,
          foregroundColor: Colors.black,
          onPressed: () {},
          child: Text(
            timeRemaining.toString(),
            style: const TextStyle(
              fontFamily: 'ModernSans',
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        )));
  }

  Widget newTimer() {
    return FittedBox(
    child: FloatingActionButton(
      backgroundColor: Colors.red,
      onPressed: () {  },
      child: NeonCircularTimer(
      width: 100,
      duration: 60,
      controller : timerController,
      isTimerTextShown: true,
      neumorphicEffect: false,
      innerFillGradient: const LinearGradient(colors: [
        Colors.orange,
        Colors.orangeAccent,
        Colors.yellow
      ]),
        textStyle: const TextStyle(
          fontFamily: 'ModernSans',
          fontSize: 22,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        textFormat: TextFormat.SS,
    )));
  }

  Future openMenuNotClosable() {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: false,
        //elevates modal bottom screen
        elevation: 10,
        // gives rounded corner to modal bottom screen
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (BuildContext context) {
          return soloUserMustResponseDialog(
              context, userMustResponseController);
        }).then((value) => {
          if (value != null)
            {checkResponse(value)}
          else
            {checkResponse('skipTurn')}
        });
  }

  /// Se il BottomSheet è stato chiuso è paerchè l'utente può aver voluto visualizzare bene gli indizi
  /// o aver inserito una risposta. Per controllare ciò bisogna effettuare un controllo sul valore del controller.
  checkResponse(var userWord) {
    cancelTimer();
    if (userWord != 'skipTurn') {
      userResponses.add(userWord);
      String word = userWord.trim().toLowerCase();
      String correctResponse = currentQuestion.nome.trim().toLowerCase();
      if (word == correctResponse ||
          currentQuestion.risposteEsatte.contains(word)) {
        userWin();
      } else {
        userLoseRound();
      }
    } else {
      userResponses.add("...");
      loadingBotResponse(context);
    }
  }

  userWin() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: '${currentQuestion.nome} indovinata!',
      titleTextStyle: const TextStyle(
        fontFamily: 'ModernSans',
        fontSize: 25,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      descTextStyle: const TextStyle(
        fontFamily: 'ModernSans',
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      desc: 'Allora sei un fuoriclasse',
      btnOkOnPress: () {
        setState(() {
          newTurn();
        });
      },
    ).show();
  }

  userLoseRound() {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Hai sbagliato!',
      titleTextStyle: const TextStyle(
        fontFamily: 'ModernSans',
        fontSize: 25,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      desc: 'Ritenta, vedrai che andrà meglio...',
      descTextStyle: const TextStyle(
        fontFamily: 'ModernSans',
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      btnOkOnPress: () {
        loadingBotResponse(context);
      },
    ).show();
  }

  loadingBotResponse(BuildContext context) async {
    timer.cancel();
    // show the loading dialog
    showDialog(
        barrierDismissible:
            false, // The user CANNOT close this dialog  by pressing outsite it
        context: context,
        builder: (_) {
          return WillPopScope(
            //gestione backButton
            onWillPop: () async => false,
            child: Dialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // The loading indicator
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.network(
                          // you can replace this with Image.asset
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdNeK3yAIGX27DbmBkkqNm8RA6Lj9gldW0fA&usqp=CAU',
                          fit: BoxFit.cover,
                          height: 60,
                          width: 60,
                        ),
                        const SizedBox(
                          height: 80,
                          width: 80,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.orange),
                            strokeWidth: 2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    // Some text
                    const Text(
                      "Mr.Q sta pensando...",
                      style: TextStyle(
                        fontFamily: 'ModernSans',
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        });

    await Future.delayed(const Duration(seconds: 1))
        .then((value) => {Navigator.of(context).pop(), botDialog()});
  }

  botDialog() {
    botWinCounter -= 1;
    print("Il bot vince tra: ${botWinCounter} turni");
    if (botWinCounter != 0) {
      AwesomeDialog(
        dismissOnTouchOutside: false,
        dismissOnBackKeyPress: false,
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        titleTextStyle: const TextStyle(
          fontFamily: 'ModernSans',
          fontSize: 25,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        title: 'Mr.Q dice ' + currentQuestion.risposteBot[currentClueIndex],
        desc: 'Ma ha sbagliato, almeno hai escluso una parola',
        descTextStyle: const TextStyle(
          fontFamily: 'ModernSans',
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        btnOkOnPress: () {
          setState(() {
            addNewClue();
          });
        },
      ).show();
    } else {
      AwesomeDialog(
        dismissOnTouchOutside: false,
        dismissOnBackKeyPress: false,
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.rightSlide,
        titleTextStyle: const TextStyle(
          fontFamily: 'ModernSans',
          fontSize: 25,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        title: 'Mr.Q dice ' + currentQuestion.nome,
        desc: "e ha indovinato. D'altro canto Mr.Q è abbastanza skillato",
        descTextStyle: const TextStyle(
          fontFamily: 'ModernSans',
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        btnOkOnPress: () {
          setState(() {
            createNewQuestion();
            addNewClue();
          });
        },
      ).show();
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  void newTurn() {
    AlertDialog(
        title: Text('Showing Lip'),
    content: Container(
    child: Image.asset(
    'assets/sea.gif',
    height: 125.0,
    width: 125.0,
    ),
    ));
  }


}
