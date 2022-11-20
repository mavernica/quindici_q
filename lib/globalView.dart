import 'package:flutter/material.dart';

class GlobalView {
  static Future<int?> displayDialogSelectWordWithCallBack(
      BuildContext context, List<String> words) async {
    return await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text("ciao"),
          content: Container(
            height: 300.0, // Change as per your requirement
            width: 300.0,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ListView.builder(
                padding: const EdgeInsets.all(
                    0), //sennò aggiunge uno spazio in alto per qualche motivo
                itemCount: words.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context, index); //il page builder ha bisogno di un indice per saltare alla posizione
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      height: 60,
                      width: 400,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        words[index],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
