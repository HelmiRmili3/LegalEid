import 'package:flutter/material.dart';

class TextLabel extends StatelessWidget {
  final Color bgcolor;
  final String text;
  const TextLabel({
    Key? key,
    required this.bgcolor,
    required this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: bgcolor,
        height: 30,
        width: double.infinity,
        child: Text(
          text,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
