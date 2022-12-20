import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

Widget soloUserAndBotResponses(BuildContext context, List<String> userResponses,
    int currentClueIndex, List risposteBot) {
  return  SizedBox(
          height: 300,
          child: Column(children: <Widget>[
            const SizedBox(height: 10),
            const Text(
              "Risposte",
              style: TextStyle(
                fontFamily: 'ModernSans',
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8),
                child: SizedBox(
                  height: 240,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ListView.separated(
                      padding: const EdgeInsets.all(0),
                      separatorBuilder: (context, index) => const Divider(
                            color: Colors.black,
                          ),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: userResponses.length, //se usi l'utente la lista può essere anche vuota
                      itemBuilder: (BuildContext context, int index) {
                        return Column(children: <Widget>[
                          Text(
                            userResponses[index],
                            style: const TextStyle(
                              fontFamily: 'ModernSans',
                              fontSize: 25,
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            risposteBot[index],
                            style: const TextStyle(
                              fontFamily: 'ModernSans',
                              fontSize: 25,
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ]);
                      })),
            )
            )]));
}

