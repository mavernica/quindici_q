import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class HomePageBackground extends StatelessWidget {
  const HomePageBackground({super.key});

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;

    return ClipPath(
      clipper: WaveClipperOne(),
      child: Container(
        height: screenHeight * 0.4,
        decoration: const BoxDecoration (
            image: DecorationImage(
              image: AssetImage("assets/mosaico.png"), //Simplified Pixabay License
              fit: BoxFit.fill
            )
        ),
      ),
    );
  }
}

