import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../components/no_data.dart';
import '../components/my_card.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final List<Map<String, dynamic>> _cases = [];
  _fetch() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('data')
        .doc(uid)
        .collection('cases')
        .get()
        .then((transaction) {
      for (var element in transaction.docs) {
        _cases.add(element.data().map((key, value) => MapEntry(key, value)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: _fetch(),
              builder: (context, index) {
                if (index.connectionState == ConnectionState.done) {
                  if (_cases.isNotEmpty) {
                    return ListView.builder(
                      itemCount: _cases.length,
                      itemBuilder: ((context, index) {
                        return MyCard(
                            id: _cases[index]['id'].toString(),
                            code: _cases[index]['code'].toString(),
                            year: _cases[index]['year'].toString(),
                            loyerName: _cases[index]['lawyer'].toString(),
                            typeOfCase: _cases[index]['type'].toString(),
                            court: _cases[index]['court'].toString(),
                            circule: _cases[index]['circule'].toString(),
                            details: _cases[index]['details'].toString());
                      }),
                    );
                  } else {
                    return const Nodata();
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
