import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'components/add_fake_appointement.dart';
import 'components/add_fake_case.dart';
import 'components/add_fake_payment.dart';
//import 'components/modifier_user_data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Profile extends StatelessWidget {
  static String routeName = "/profile";

  const Profile({Key? key}) : super(key: key);
  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            child:const Padding(
              padding:  EdgeInsets.all(8.0),
              child:  Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  });
              FirebaseAuth.instance.signOut().then((value) async {
                await storage.delete(key: 'uid').then((value) {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/auth');
                });
              }).onError((error, stackTrace) {
              });
            },
          )
        ],
      ),
      //body: MyForm(),
      body: Container(
        padding: const EdgeInsets.all(100),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          // ElevatedButton(
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => const ModifierUserData(),
          //         ),
          //       );
          //     },
          //     child: const Text('Modifier user data')),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddFakePayment(),
                  ),
                );
              },
              child: const Text('Add fake payment')),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddFakeAppointement(),
                  ),
                );
              },
              child: const Text('Add fake appointement')),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddFakeCase(),
                  ),
                );
              },
              child: const Text('Add fake case'))
        ]),
      ),
    );
  }
}
