import 'package:flutter/material.dart';
import '../cases/components/body.dart';

class Cases extends StatelessWidget {
  static String routeName = "/cases";

  const Cases({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Cases',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: const Body(),
    );
  }
}
