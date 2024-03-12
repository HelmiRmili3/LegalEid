import 'package:flutter/material.dart';

class Nodata extends StatelessWidget {
  const Nodata({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.1),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset('assets/images/empty-box.png'),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'No data found!',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ]),
      ),
    );
  }
}
