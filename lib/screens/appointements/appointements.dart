import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testapp/screens/appointementdetails/appointements_details.dart'
    as h;
import '../../components/no_data.dart';

class Appointements extends StatefulWidget {
  static String routeName = "/appointements";

  const Appointements({Key? key}) : super(key: key);

  @override
  State<Appointements> createState() => _AppointementsState();
}

class _AppointementsState extends State<Appointements> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> appointements = [];
    _fetch() async {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('data')
          .doc(uid)
          .collection('appointements')
          .get()
          .then((transaction) {
        for (var element in transaction.docs) {
          appointements.add(element.data());
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Appointements'),
      ),
      body: FutureBuilder(
        future: _fetch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (appointements.isNotEmpty) {
              return ListView.builder(
                itemCount: appointements.length,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      shadowColor: Colors.blue,
                      elevation: 5,
                      child: Container(
                        color: Colors.blue.withOpacity(0.5),
                        child: ListTile(
                          title: Text(
                            'Date : ${appointements[index]['date']}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                              'Time : ${appointements[index]['time']}',
                              style: const TextStyle(color: Colors.black)),
                          trailing: IconButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => h.AppointementsDetails(
                                    appointements[index]),
                              ),
                            ),
                            icon: const Icon(Icons.arrow_forward),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              );
            } else {
              return const  Nodata();
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
