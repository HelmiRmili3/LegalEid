import 'package:flutter/material.dart';

class CastomLabel extends StatelessWidget {
  final String lefttext;
  final String righttext;
  final Color bgcolor;
  final double boxwith;
  const CastomLabel({
    Key? key,
    required this.lefttext,
    this.boxwith = 10,
    this.righttext = '',
    this.bgcolor = const Color.fromARGB(255, 252, 251, 251),
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgcolor,
      height: 40,
      padding: const EdgeInsets.all(3),
      child: Row(children: [
        SizedBox(
          width: boxwith,
        ),
        Expanded(
          child: Text(
            lefttext,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(
            righttext,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: boxwith,
        ),
      ]),
    );
  }
}
