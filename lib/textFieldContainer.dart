import 'package:flutter/material.dart';
import 'hexToColor.dart';

Widget textFieldContainer(BuildContext context, TextEditingController controllerText) {
  
  return Container(
      height: 500,
      padding: const EdgeInsets.all(30.0),
      color: Colors.white,
      child: SizedBox(
          child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      controller: controllerText,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User Name',
                        hintText: 'Enter Your Name',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        textStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    child: const Text('Crea'),
                    onPressed: () {
                      if (controllerText.text.isNotEmpty) {
                        print("Close Dialog");
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Inserisci un nome...'),
                        ));
                      }
                    },
                  )
                ],
              ))));
}

