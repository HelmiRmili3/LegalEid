//Importing packages
import 'package:flutter/material.dart';

//Importing components
import 'components/body.dart';

//Importing pages

class Dashboard extends StatefulWidget {
  static String routeName = "/dashboard";

  const Dashboard({super.key});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor:Colors.blue,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
      ),
      body:const Body(),
    );
  }
}
