// import this Package in pubspec.yaml file
// dependencies:
//
//   animated_text_kit:

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class subtitleAnimation extends StatefulWidget {
  const subtitleAnimation({Key? key}) : super(key: key);

  @override
  State<subtitleAnimation> createState() => _subtitleAnimationState();
}

class _subtitleAnimationState extends State<subtitleAnimation> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      
    child: Center(
        child: AnimatedTextKit(
          
          pause: Duration(milliseconds: 300),
          
          animatedTexts: [
            TypewriterAnimatedText(
              'play Your Faoutite Tunes..',
              speed: Duration(milliseconds: 150),
              textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'font1',
              ),
            ),
          ],
          isRepeatingAnimation: true,
          repeatForever: true,
          displayFullTextOnTap: true,
          stopPauseOnTap: false,
        ),
      ),
    );
  }
}