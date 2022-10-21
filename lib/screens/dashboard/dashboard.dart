//Importing packages
import 'package:flutter/material.dart';

//Importing components
import 'components/body.dart';

//Importing pages

class Dashboard extends StatefulWidget {
  static String routeName = "/dashboard";

  const Dashboard({Key? key}) : super(key: key);
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor:Color.fromARGB(26, 245, 240, 240),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: Colors.black,
          ),
          //textAlign: TextAlign.start,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body:const Body(),
    );
  }
}
