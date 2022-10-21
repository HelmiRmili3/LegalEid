import 'package:flutter/material.dart';
import '../cases/components/body.dart';

class Cases extends StatelessWidget {
  static String routeName = "/cases";

  const Cases({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Cases',style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body:const Body(),
    );
  }
}
