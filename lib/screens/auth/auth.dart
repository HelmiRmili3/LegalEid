import 'package:flutter/material.dart';
import '../auth/components/body.dart';

class Auth extends StatelessWidget {
  static String routeName = "/auth";

  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  Body(),
    );
  }
}
