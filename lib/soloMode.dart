import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quindici_q/coopModeClass.dart';
import 'package:quindici_q/soloModelClass.dart';
import 'package:quindici_q/textFieldContainer.dart';
import 'ButtonGeneratorSolo.dart';
import 'constants.dart';
import 'myAppBar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class SoloMode extends StatefulWidget {
  const SoloMode({super.key});

  @override
  State<SoloMode> createState() => _SoloModeState();
}

class _SoloModeState extends State<SoloMode> {
  Random random = Random();
  TextEditingController controllerText = TextEditingController();

  List<SoloQuestion> questionsGetFromDb = [];

  late SoloQuestion actualQuestion; //elemento che viene visualizzato
  List<String> listOfClue = []; //lista di indizi

  int clueIndex =
      0; //contiene indizi già visualizzati per escluderli quando vengono aggiunti

  PageController? controller;

  late Timer timer;
  int timeRemaining = 60;
  bool menuIsOpen = false;

  @override
  void initState() {
    super.initState();
  }

  void createNewQuestion() {
    //int randomNumber = random.nextInt(90) + 10; // from 10 upto 99 included
    actualQuestion = questionsGetFromDb[1];
  }

  void addNewClue() {
    listOfClue.add(actualQuestion.indizi[clueIndex]);
    clueIndex += 1;
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
          bottomNavigationBar: ResultNavBar(context),
          extendBodyBehindAppBar: true,
          floatingActionButton: circleTimer(),
          appBar: const MyAppBar(),
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
                        'assets/pacman.gif', // Put your gif into the assets folder
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
                Text(
                  "???",
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
                  padding: const EdgeInsets.all(0),
                  //sennò aggiunge uno spazio in alto per qualche motivo
                  itemCount: listOfClue.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    //primo bottone
                    return ButtonGeneratorSolo(listOfClue,
                        index); //15 domande e passo indice per impostare l'indizio
                  },
                ),
              ],
            )));
  }

  Widget ResultNavBar(BuildContext context) {
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
                  return SizedBox();
                },
              );
            },
            child: const SizedBox(
              height: kToolbarHeight,
              width: 130,
              child: Center(
                child: Text(
                  'Rispondi',
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
                menuIsOpen = true;
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    builder: (BuildContext context) {
                      return textFieldContainer(context, controllerText);
                    }).then((value) => checkResponse());
              },
              child: const SizedBox(
                height: kToolbarHeight, //altezza bottone in bassi
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

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timeRemaining = 60;
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (timeRemaining == 0) {
          setState(() {
            timer.cancel();
            if (menuIsOpen) {
              //Navigator.pop(context);
            }
            //openMenuNotClosable();
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
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
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
          return textFieldContainer(context, controllerText);
        }).then((value) => checkResponse());
  }

  /// Se il BottomSheet è stato chiuso è paerchè l'utente può aver voluto visualizzare bene gli indizi
  /// o aver inserito una risposta. Per controllare ciò bisogna effettuare un controllo sul valore del controller.
  checkResponse() {
    if (controllerText.text.isEmpty) {
      menuIsOpen = false;
    } else {
      cancelTimer();
      if (controllerText.text == actualQuestion.nome || actualQuestion.risposteEsatte.contains(controllerText.text)) {
        userWin();
      } else {
        userLoseRound();
      }
    }
  }

  userWin() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: actualQuestion.nome + ' indovinata!',
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
      desc: 'Ritenta, vedrai che andrà meglio...',
      btnOkOnPress: () {
        loadingBotResponse(context);
      },
    ).show();
  }

  loadingBotResponse(BuildContext context) async {
    // show the loading dialog
    showDialog(
        barrierDismissible:
            false, // The user CANNOT close this dialog  by pressing outsite it
        context: context,
        builder: (_) {
          return WillPopScope( //gestione backButton
            onWillPop: () async => false,
            child: Dialog(
              // The background color
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    // The loading indicator
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 15,
                    ),
                    // Some text
                    Text('Il bot sta pensando...')
                  ],
                ),
              ),
            ),
          );
        });

    await Future.delayed(const Duration(seconds: 3))
        .then((value) => {Navigator.of(context).pop(), botDialog()});
  }

  botDialog() {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.rightSlide,
      title: 'Il BOT dice ' + actualQuestion.risposteBot[clueIndex],
      desc: 'Ma ha sbagliato, almeno hai escluso una parola ;D',
      btnOkOnPress: () {
        setState(() {
          addNewClue();
          startTimer();
        });
      },
    ).show();
  }
}
