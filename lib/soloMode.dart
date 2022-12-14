import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quindici_q/coopModeClass.dart';
import 'package:quindici_q/soloModelClass.dart';
import 'package:quindici_q/soloUserAndBotResponses.dart';
import 'package:quindici_q/soloUserCanResponseDialog.dart';
import 'package:quindici_q/soloUserMustResponseDialog.dart';
import 'ButtonGeneratorSolo.dart';
import 'constants.dart';
import 'myAppBar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SoloMode extends StatefulWidget {
  const SoloMode({super.key});

  @override
  State<SoloMode> createState() => _SoloModeState();
}

class _SoloModeState extends State<SoloMode> {
  Random random = Random();
  int botResponseIndex = 0;

  List<SoloQuestion> questionsGetFromDb = [];

  late SoloQuestion currentQuestion; //elemento che viene visualizzato

  late List<String> listOfClue; //lista di indizi in forma di stringa
  late List<int> listOfClueIndex; //lista di indizi già presenti in forma di interi

  late List<String> userResponses = []; //risposte utente

  PageController? controller;

  late Timer timer;
  int timeRemaining = 60;
  bool menuIsOpen = false;

  @override
  void initState() {
    super.initState();
  }

  void createNewQuestion() {
    print("Created new questins - ENTRO 1 SOLA VOLTA QUA");
    currentQuestion = questionsGetFromDb[1];
    currentQuestion.risposteEsatte = currentQuestion.risposteEsatte
        .map((word) => word.toLowerCase())
        .toList();
    listOfClue = [];
    listOfClueIndex = [];
    userResponses = [];
  }

  /// genera un nuovo indizio utilizzando un valore casuale compreso tra 0 e 20
  void addNewClue() {
    int randomNumber = random.nextInt(21) + 0; // from right to sum of them -1
    while (listOfClueIndex.contains(randomNumber)) { //finchè il numero random è giù uscito ne generi uno nuovo
      randomNumber = random.nextInt(20) + 0;
    }
    listOfClueIndex.add(randomNumber);
    listOfClue.add(currentQuestion.indizi[randomNumber]);
    print("Indizi mostrati$listOfClueIndex");
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Image.asset(
        "assets/bg2.jpg",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: resultNavBar(context),
          extendBodyBehindAppBar: true,
          floatingActionButton: circleTimer(),
          appBar: const MyAppBarBack(),
          body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance
                  .collection("questionSolo")
                  .limit(3)
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
                    startTimer(); //faccio partire il timer

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
              }))
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
                    color: Colors.white,
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
                  return soloUserAndBotResponses(context, userResponses, botResponseIndex, currentQuestion.risposteBot);
                },
              );
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
                      return soloUserCanResponseDialog(context);
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
          return soloUserMustResponseDialog(context);
        }).then((value) => {
          if (value != null)
            {checkResponse(value)}
          else
            {
              checkResponse('skipTurn')
        }});
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
      desc: 'Allora sei un fuoriclasso',
      btnOkOnPress: () {},
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
                      "Il BOT sta pensando...",
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
      title: 'Il BOT dice ' + currentQuestion.risposteBot[botResponseIndex],
      desc: 'Ma ha sbagliato, almeno hai escluso una parola',
      descTextStyle: const TextStyle(
        fontFamily: 'ModernSans',
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      btnOkOnPress: () {
        setState(() {
          botResponseIndex += 1;
          addNewClue();
          startTimer();
        });
      },
    ).show();
  }
}
