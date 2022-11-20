import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quindici_q/standardModeClass.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

/**
Si vince con 10. più è vicino a 0 più l'onda è alta.
 * **/

Widget pointSummary(BuildContext context, List<Team> teams) {
  const _backgroundColor = Color(0xFFb6fbff);

  const _colors = [
    Color(0xFF00c6ff),
    Color(0xFF0072ff),
  ];

  const _durations = [
    5000,
    4000,
  ];

  return SizedBox(
      height: 600,
      child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <
              Widget>[
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Riepilogo",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                  width: 180,
                  height: 180,
                  child: Stack(children: [
                    WaveWidget(
                      config: CustomConfig(
                        colors: _colors,
                        durations: _durations,
                        heightPercentages: [
                          (100 - teams[0].point.toDouble()) / 100,
                          (100 - teams[0].point.toDouble()) / 100 + 0.1
                        ],
                      ),
                      backgroundColor: _backgroundColor,
                      size: const Size(double.infinity, double.infinity),
                      waveAmplitude: 0,
                    ),
                    Center(
                        child: Text(
                      teams[0].name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                      ),
                    )),
                  ])),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                  width: 180,
                  height: 180,
                  child: Stack(children: [
                    WaveWidget(
                      config: CustomConfig(
                        colors: _colors,
                        durations: _durations,
                        heightPercentages: [
                          (100 - teams[1].point.toDouble()) / 100,
                          (100 - teams[1].point.toDouble()) / 100 + 0.1
                        ],
                      ),
                      backgroundColor: _backgroundColor,
                      size: const Size(double.infinity, double.infinity),
                      waveAmplitude: 0,
                    ),
                    Center(
                        child: Text(
                      teams[1].name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                      ),
                    )),
                  ])),
            )
          ]),
        ),
        Text(
          teams[0].name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        Text(
          "Parole indovinate " + teams[0].wordsCount.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        Text(
          "Punteggio " + teams[0].point.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ])));
}
