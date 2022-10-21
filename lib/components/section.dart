import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Section extends StatelessWidget {
  Section(
      {Key? key,
      required this.headercolor,
      required this.title,
      required this.value})
      : super(key: key);

  Color headercolor = Colors.green;
   var title='';
   var value=0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Container(
              height: 150,
              width: 200,
              color: Colors.blue,
              // decoration: BoxDecoration(
              //   color: Colors.blueAccent,
              //   borderRadius: const BorderRadius.only(
              //       topLeft: Radius.circular(10),
              //       topRight: Radius.circular(10),
              //       bottomLeft: Radius.circular(10),
              //       bottomRight: Radius.circular(10)),
              //   boxShadow: [
              //     BoxShadow(
              //       color: headercolor.withOpacity(0.5),
              //       spreadRadius: 5,
              //       blurRadius: 10,
              //       offset: const Offset(0, 3),
              //     ),
              //   ],
              // ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(200),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 20, left: 20, right: 4, bottom: 4),
                  height: 60,
                  width: 60,
                  color:
                      const Color.fromARGB(255, 119, 169, 255).withOpacity(0.3),
                  child: FittedBox(
                      child: Text(
                    '$value',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              height: 60,
              width: 200,
              //color: Colors.amber,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  //fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
