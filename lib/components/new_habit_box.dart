import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EnterNewHabit extends StatelessWidget {
  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final String hintText;

  const EnterNewHabit({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Container(
            height: 200,
            width: 200,
            child: Lottie.asset(
              'asset/Task.json',
            ),
          ),
          Text(
            'Create new habit',
            style: TextStyle(fontSize: 25),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Colors.deepPurple[200],
      content: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(5)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(5)),
        ),
      ),
      actions: [
        MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          onPressed: onSave,
          child: Text('Save', style: TextStyle(fontSize: 20)),
          color: Colors.deepPurple[600],
        ),
        SizedBox(
          width: 5,
        ),
        MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          onPressed: onCancel,
          child: Text(
            'Cancel',
            style: TextStyle(fontSize: 20),
          ),
          color: Colors.deepPurple[600],
        )
      ],
    );
  }
}
