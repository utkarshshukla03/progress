import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage2 extends StatelessWidget {
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
              child: Lottie.asset(
                'asset/NotesI.json',
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Jot Down Notes & Track Your Progress Effortlessly!',
                style: TextStyle(fontSize: 30, fontFamily: 'Fredoka'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
