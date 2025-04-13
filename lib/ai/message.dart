import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  const Message({super.key, required this.text, required this.sender});

  final String text;
  final String sender;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: sender == 'user' ? Colors.blue : Colors.grey[300],
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: sender == 'user' ? Colors.white : Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
