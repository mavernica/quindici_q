import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quindici_q/coopModeClass.dart';

class ButtonGeneratorCoop extends StatefulWidget {

  Question sq;
  int index;

  ButtonGeneratorCoop(this.sq, this.index, {Key? key}) : super(key: key);

  @override
  _ButtonGeneratorCoopState createState() => _ButtonGeneratorCoopState();
}

class _ButtonGeneratorCoopState extends State<ButtonGeneratorCoop> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          pressed = !pressed;
          widget.sq.questionsPressed[widget.index] = !widget.sq.questionsPressed[widget.index];
        });
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        height: 60,
        width: 400,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        alignment: Alignment.center,
        child: Text(
            widget.sq.indizi[widget.index],
          style: pressed
              ? const TextStyle(color: Colors.blueAccent)
              : const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
