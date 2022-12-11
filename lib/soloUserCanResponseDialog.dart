import 'package:flutter/material.dart';

Widget soloUserCanResponseDialog(BuildContext context) {
  TextEditingController controllerText = TextEditingController();

  return Padding(
      //obbligatorio se si vuole che la tastiera si alzi
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
          height: 180,
          padding: const EdgeInsets.all(16.0),
          color: Colors.white,
          child: Column(children: <Widget>[
            const SizedBox(height: 25),
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
                      hintStyle:
                          const TextStyle(fontSize: 16, color: Colors.black45),
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
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
          ])));
}
