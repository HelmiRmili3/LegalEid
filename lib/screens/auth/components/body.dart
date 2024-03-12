import 'package:flutter/material.dart';
import 'form.dart';


class Body extends StatelessWidget {
  const Body({super.key});
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: Center(
          child: Column(children: [
            SizedBox(
              height: 280,
              width: double.infinity,
              child: Image.asset('assets/images/banner.jpg'),
            ),
            Container(
              alignment: Alignment.topLeft,
              height: 40,
              width: double.infinity,
              child: const Text(
                'Welcome Back!',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              height: 50,
              width: double.infinity,
              child: const Text(
                'This is Legal Aid , We make your days easier',
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
            ),
            const CustomForm(),
          ]),
        ),
      ),
    );
  }
}
