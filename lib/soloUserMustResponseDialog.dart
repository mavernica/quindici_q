import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:double_back_to_close/double_back_to_close.dart';

Widget soloUserMustResponseDialog(BuildContext context) {
  DateTime pre_backpress = DateTime.now();
  TextEditingController controllerText = TextEditingController();

  return DoubleBack(
      waitForSecondBackPress: 15,
      onFirstBackPress: (context) {
        Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          isDismissible: true,
          message:
              "Andando indietro perderei la possibilità di rispondere. Premi due volte per saltare il turno.",
          icon: Icon(
            Icons.info_outline,
            size: 28.0,
            color: Colors.blue[300],
          ),
          duration: const Duration(seconds: 4),
          leftBarIndicatorColor: Colors.blue[300],
        ).show(context);
      },
      child: Padding(
          //obbligatorio se si vuole che la tastiera si alzi
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
              height: 220,
              padding: const EdgeInsets.all(16.0),
              color: Colors.white,
              child: Column(children: <Widget>[
                const SizedBox(height: 25),
                const Text(
                  "Hai esaurito il tempo, devi rispondere!",
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Material(
                    elevation: 5.0,
                    shadowColor: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(15.0),
                    child: TextFormField(
                      controller: controllerText,
                      obscureText: false,
                      autofocus: false,
                      decoration: InputDecoration(
                          hintText: 'Prova a indovinare...',
                          hintStyle: const TextStyle(
                              fontSize: 16, color: Colors.black45),
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon:
                              const Icon(Icons.help, color: Colors.blueAccent),
                          suffixIcon: const Material(
                            elevation: 5.0,
                            color: Colors.blueAccent,
                            shadowColor: Colors.blueAccent,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15.0),
                              bottomRight: Radius.circular(15.0),
                            ),
                            child: Icon(Icons.search, color: Colors.white),
                          ),
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
                          backgroundColor: Colors.blue,
                          textStyle: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      child: const Text('Verifica'),
                      onPressed: () {
                        if (controllerText.text.isNotEmpty) {
                          Navigator.pop(context, controllerText.text);
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Inserisci un nome...'),
                          ));
                        }
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          textStyle: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      child: const Text('Passa'),
                      onPressed: () {
                        Navigator.pop(context, "skipTurn");
                      },
                    )
                  ],
                )
              ]))));
}
