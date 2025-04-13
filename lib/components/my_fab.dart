import 'package:flutter/material.dart';

class MyFloatingActionButton extends StatelessWidget {
  final Function()? onPressed;
  const MyFloatingActionButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: FittedBox(
        child: FloatingActionButton(
          hoverColor: Colors.indigo,
          backgroundColor: Colors.pink,
          onPressed: onPressed,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
