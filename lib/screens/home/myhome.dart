import 'package:flutter/material.dart';
import '../dashboard/dashboard.dart';
import '../cases/cases.dart';
import '../appointements/appointements.dart';
import '../profile/porfile.dart';

class MyHome extends StatefulWidget {
  static String routeName = "/myhome";

  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int _currentIndex = 0;
  final List<Widget> _pages = const <Widget>[
    Dashboard(),
    Cases(),
    Appointements(),
    Profile(),
  ];
  void _onItemTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  _pages[_currentIndex],
      bottomNavigationBar: SizedBox(
         height: 50,
        width: double.infinity,
        child: BottomNavigationBar(
          onTap: _onItemTap,
          currentIndex: _currentIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          showSelectedLabels: true,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 8),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          elevation: 5,
          items: const <BottomNavigationBarItem> [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.download),
              label: 'Cases',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timer),
              label: 'Appointements',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
