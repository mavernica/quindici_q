import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class HomePageBackground extends StatelessWidget {
  const HomePageBackground({super.key});

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidht = MediaQuery.of(context).size.width;

    return SizedBox(
        height: screenHeight * 0.4,
        width: screenWidht,
        child: Stack(
        children: [
          Image.asset(
              'assets/prova2.png',
              fit: BoxFit.fill
            ),
          Image.asset(
              'assets/prova1.png',
              fit: BoxFit.fill
          ),
        ]
      ),
    );
  }
}

