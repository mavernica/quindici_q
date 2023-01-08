import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';


Widget soloUserCanResponseDialog(BuildContext context, TextEditingController userCanResponseController) {

  final screenHeight = MediaQuery.of(context).size.height;

  return Padding(
      //obbligatorio se si vuole che la tastiera si alzi
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
          height: screenHeight * 0.25,
          child: Column(children: <Widget>[
            const SizedBox(height: 10),
            const Padding(padding: EdgeInsets.all(8),
            child: Text(
              "Inserisci la tua risposta. Il fatto che i caratteri siano in maiuscolo o minuscolo, non cambia; come non "
                  "influisce la presenza di spazi all'inizio o alla fine della risposta.",
              style: TextStyle(
                fontFamily: 'ModernSans',
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Material(
                elevation: 5.0,
                shadowColor: Colors.blueAccent,
                borderRadius: BorderRadius.circular(15.0),
                child: TextFormField(
                  controller: userCanResponseController,
                  obscureText: false,
                  autofocus: false,
                  decoration: InputDecoration(
                      hintText: 'Inserisci la tua riposta...',
                      hintStyle:
                          const TextStyle(
                            fontFamily: 'ModernSans',
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon:
                          const Icon(Icons.help, color: Colors.blueAccent),
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(
                              color: Colors.white, width: 3.0))),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    textStyle: const TextStyle(
                      fontFamily: 'ModernSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Passa'),
                  onPressed: () {
                    Navigator.pop(context, "skipTurn");
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    textStyle: const TextStyle(
                      fontFamily: 'ModernSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Verifica'),
                  onPressed: () {
                    if (userCanResponseController.text.isNotEmpty) {
                      Navigator.pop(context, userCanResponseController.text);
                      userCanResponseController.text = "";
                    } else {
                      Flushbar(
                        flushbarPosition: FlushbarPosition.TOP,
                        isDismissible: true,
                        messageText: const Text(
                          "Sembra tu non abbia inserito alcuna risposta...",
                          style: TextStyle(
                            fontFamily: 'ModernSans',
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        icon: Icon(
                          Icons.info_outline,
                          size: 28.0,
                          color: Colors.blue[300],
                        ),
                        duration: const Duration(seconds: 2),
                        leftBarIndicatorColor: Colors.blue[300],
                      ).show(context);
                    }
                  },
                ),
              ],
            )
          ])));
}
