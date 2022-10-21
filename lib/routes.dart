import 'package:flutter/material.dart';
import 'screens/spashscreen/spalshscreen.dart';
import 'screens/profile/porfile.dart';
import 'screens/home/myhome.dart';
import 'screens/dashboard/dashboard.dart';
import 'screens/cases/cases.dart';
//import 'screens/caseDetails/case_details.dart';
import 'screens/auth/auth.dart';
import 'screens/appointements/appointements.dart';
//import 'screens/appointementDetails/appointements_details.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  Profile.routeName: (context) => const Profile(),
  MyHome.routeName: (context) => const MyHome(),
  Dashboard.routeName: (context) => const Dashboard(),
  Cases.routeName: (context) => const Cases(),
  //CaseDetails.routeName: (context) =>  CaseDetails(id: id),
  Auth.routeName: (context) => const Auth(),
  Appointements.routeName: (context) => const Appointements(),
  //AppointementsDetails.routeName: (context) =>  AppointementsDetails(),
};
