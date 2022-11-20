import 'package:countup/countup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quindici_q/standardModeClass.dart';

void showPointIncreased(BuildContext context, List<Team> teams) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            content: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Riepilogo punteggi",
                        style: TextStyle(fontSize: 30),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            "${teams[0].name}:",
                            style: const TextStyle(fontSize: 26),
                          ),
                          Countup(
                            begin: 0,
                            end: teams[0].point.toDouble(),
                            duration: const Duration(seconds: 1),
                            separator: ',',
                            style: const TextStyle(
                              fontSize: 26,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "${teams[1].name}:",
                            style: const TextStyle(fontSize: 26),
                          ),
                          Countup(
                            begin: 0,
                            end: teams[1].point.toDouble(),
                            duration: const Duration(seconds: 1),
                            separator: ',',
                            style: const TextStyle(
                              fontSize: 26,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top: -100,
                    child: Image.network("https://i.imgur.com/2yaf2wb.png",
                        width: 150, height: 150))
              ],
            ));
      }).then((value) => Navigator.pop(context));
}
