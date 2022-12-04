import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quindici_q/coopModeClass.dart';

class ButtonGeneratorSolo extends StatefulWidget {

  List<String> clues;
  int index;

  ButtonGeneratorSolo(this.clues, this.index, {Key? key}) : super(key: key);

  @override
  ButtonGeneratorSoloState createState() => ButtonGeneratorSoloState();
}

class ButtonGeneratorSoloState extends State<ButtonGeneratorSolo> {

  @override
  Widget build(BuildContext context) {
    return  Container(
        margin: const EdgeInsets.all(8),
        height: 60,
        width: 400,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        alignment: Alignment.center,
        child: Text(
          widget.clues[widget.index]
        ),
      );
  }
}
