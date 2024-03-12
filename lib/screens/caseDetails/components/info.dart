import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../components/section.dart';
import '../components/castom_label.dart';

// ignore: must_be_immutable
class Info extends StatelessWidget {
  final String id;
  Info({
    super.key,
    required this.id,
  });

  Map<String, dynamic> cases = {};
  _fetch() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('data')
        .doc(uid)
        .collection('cases')
        .doc(id)
        .get()
        .then((transaction) {
      cases = transaction.data()!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetch(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            padding: const EdgeInsets.only(top: 10, right: 6, left: 6),
            child: Column(children: [
              SizedBox(
                height: 100,
                child: Row(
                  children: [
                    Section(
                        headercolor: Colors.green,
                        title: 'Case Amount',
                        value: cases['amount']),
                    const SizedBox(
                      width: 6,
                    ),
                    Section(
                      headercolor: Colors.red,
                      title: 'Payments',
                      value: cases['payed'],
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Section(
                      headercolor: Colors.green,
                      title: 'Remain',
                      value: cases['amount'] - cases['payed'],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  CastomLabel(
                    boxwith: 0,
                    lefttext: 'Case Code :',
                    righttext: "${cases['code']}/${cases['year']}",
                    bgcolor: Colors.grey,
                  ),
                  CastomLabel(
                    lefttext: 'Case number :',
                    righttext: '${cases['code']}',
                  ),
                  CastomLabel(
                    lefttext: 'Type :',
                    righttext: '${cases['type']}',
                  ),
                  CastomLabel(
                    lefttext: 'Status :',
                    righttext: '${cases['status']}',
                  ),
                  CastomLabel(
                    lefttext: 'Circule :',
                    righttext: '${cases['circule']}',
                  ),
                  CastomLabel(
                    lefttext: 'Court :',
                    righttext: '${cases['court']}',
                  ),
                  // const CastomLabel(
                  //   boxwith: 0,
                  //   lefttext: 'Client info :',
                  //   bgcolor: Colors.grey,
                  // ),
                  // const CastomLabel(
                  //   lefttext: 'Name',
                  //   righttext: 'sami',
                  // ),
                  // const CastomLabel(
                  //   lefttext: 'Phone',
                  //   righttext: '96458569',
                  // ),
                  // const CastomLabel(
                  //   lefttext: 'Email',
                  //   righttext: 'exemple@gmail.com',
                  // ),
                  // const CastomLabel(
                  //   lefttext: 'Address',
                  //   righttext: 'kessrine sbeitla',
                  // ),
                ],
              )
            ]),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
