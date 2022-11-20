import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quindici_q/standardMod.dart';

import 'constants.dart';
import 'myAppBar.dart';

class ChooseTeams extends StatefulWidget {
  @override
  _ChooseTeamsState createState() => _ChooseTeamsState();
}

class _ChooseTeamsState extends State<ChooseTeams> {
  // set an int with value -1 since no card has been selected
  int selectedCardFirstTeam = -1;
  int selectedCardSecondTeam = -1;
  final controllerFirstTextField = TextEditingController();
  final controllerSecondTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: const MyAppBar(),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround, // <-- alignments
                    children: <Widget>[
                      const SizedBox(height: 50), //altezza dall'alto. Obbligatoria se incorporti il body dentro l'app bar
                      Text(
                        "Crea le squadre",
                        style: TextStyle(
                          fontFamily: 'Avenir',
                          fontSize: 50,
                          color: primaryTextColor,
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 10),
                      TextField(
                          controller: controllerFirstTextField,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black87, width: 3),
                            ),
                            border: OutlineInputBorder(),
                            hintText: 'Primo team',
                          )),
                      const SizedBox(height: 10),
                      GridView.builder(
                          padding: const EdgeInsets.all(0), //sennò aggiunge uno spazio in alto per qualche motivo
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: 6,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio:
                                MediaQuery.of(context).size.width /
                                    (MediaQuery.of(context).size.height / 3),
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedCardFirstTeam = index;
                                });
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    // border color
                                    color: selectedCardFirstTeam == index
                                        ? Colors.blue
                                        : Colors.black87,
                                    // border thickness
                                    width: 3,
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/animals/animal$index.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                      const SizedBox(height: 10),
                      TextField(
                          controller: controllerSecondTextField,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black87, width: 3),
                            ),
                            border: OutlineInputBorder(),
                            hintText: 'Secondo team',
                          )),
                      const SizedBox(height: 10),
                      GridView.builder(
                          padding: const EdgeInsets.all(0), //sennò aggiunge uno spazio in alto per qualche motivo
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: 6,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio:
                                MediaQuery.of(context).size.width /
                                    (MediaQuery.of(context).size.height / 3),
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedCardSecondTeam = index;
                                });
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    // border color
                                    color: selectedCardSecondTeam == index
                                        ? Colors.blue
                                        : Colors.black87,
                                    // border thickness
                                    width: 3,
                                  ),
                                ),
                                child: Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/animals/animal${index + 6}.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                      Card( //BOTTONE ANDIAMO
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        elevation: 10,
                        color: Colors.white,
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(
                            color: Color(0xFF414C6B),
                            width: 6,
                          ),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StandardMod(
                                  team1: (controllerFirstTextField.text != '')
                                      ? controllerFirstTextField.text
                                      : "team1",
                                  team2: (controllerSecondTextField.text != '')
                                      ? controllerSecondTextField.text
                                      : "team2",
                                  team1Image: (selectedCardFirstTeam != -1)
                                      ? "assets/animals/animal$selectedCardFirstTeam.jpg"
                                      : "assets/animals/animal0.jpg",
                                  team2Image: (selectedCardSecondTeam != -1)
                                      ? "assets/animals/animal${selectedCardSecondTeam + 6}.jpg"
                                      : "assets/animals/animal6.jpg",
                                ),
                              ),
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            height: 100,
                            width: screenWidth,
                            child: const DefaultTextStyle(
                                style: TextStyle(
                                  fontSize: 35.0,
                                  color: Colors.black,
                                  fontFamily: 'Agne',
                                ),
                                child: Text("Andiamo")),
                          ),
                        ),
                      ),
                    ]))));
  }
}
