import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quindici_q/modeClass.dart';
import 'package:quindici_q/operationOnDbCoop.dart';
import 'package:quindici_q/operationOnDbSolo.dart';
import 'package:quindici_q/soloMenuPage.dart';
import 'package:quindici_q/coopMenuPage.dart';
import 'homePage.dart';
import 'instructionCoopPage.dart';
import 'instructionSoloPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // Initialize FlutterFire
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {

          // Check for errors
          if (snapshot.hasError) {
            print("Error");
            print(snapshot.error);
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {

            return MaterialApp(
              title: 'Flutter Demo',
              initialRoute: '/',
              routes: {
                // When navigating to the "/" route, build the FirstScreen widget.
                '/': (context) => const HomePage(),
                // When navigating to the "/second" route, build the SecondScreen widget.
                '/standard': (context) => CoopMenuPage(planetInfo: modeList[0]),
                '/solo': (context) => SoloMenuPage(planetInfo: modeList[1]),
                '/instructionSolo': (context) => InstructionSoloPage(),
                '/instructionCoop': (context) => InstructionCoopPage(),

              },
              theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
            );
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.red,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
          );
        });
  }
}
