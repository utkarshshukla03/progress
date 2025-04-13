import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple[300],
      child: Column(
        children: [
          Center(
            child: Container(
              height: 500,
              width: 500,
              child: Lottie.asset('asset/Ai.json'),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Ask, Learn, Achieve , Your AI Buddy is Here! 🚀🧠',
                style: TextStyle(fontSize: 30, fontFamily: 'Fredoka'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
