import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage1 extends StatelessWidget {
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
              child: Lottie.asset('asset/Work.json'),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Build Better Habits, Track Progress Visually! 📊🔥',
                style: TextStyle(fontSize: 30, fontFamily: 'Fredoka'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
