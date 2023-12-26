//Importing packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testapp/components/no_data.dart';

class PaymentsList extends StatefulWidget {
  const PaymentsList({Key? key}) : super(key: key);
  @override
  State<PaymentsList> createState() => _PaymentsListState();
}

class _PaymentsListState extends State<PaymentsList> {
  List<String> years = [];
  List<Map<String, String>> data = [];
  _fetch() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('data')
        .doc(uid)
        .collection('payments')
        .get()
        .then((transaction) {
      for (var element in transaction.docs) {
        final String year = element.data()['year'];
        if (!years.contains(year)) {
          years.add(year);
        }
        data.add(element.data().map((key, value) {
          return MapEntry(key, value);
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetch(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (years.isEmpty || data.isEmpty) {
            return const Nodata();
          } else {
            return ListView.builder(
              itemCount: years.length,
              itemBuilder: ((context, index) {
                return ExpansionTile(
                  title: Text(years[index]),
                  children:
                      (data.where((element) => element['year'] == years[index]))
                          .map((item) {
                    return CostumTile(
                        item['date'].toString(),
                        item['details'].toString(),
                        item['time'].toString(),
                        item['type'].toString());
                  }).toList(),
                );
              }),
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class CostumTile extends StatelessWidget {
  final String date;
  final String details;
  final String time;
  final String type;
  const CostumTile(
    this.date,
    this.details,
    this.time,
    this.type, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(4),
        color: Colors.blue.withOpacity(0.3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              flex: 3,
              child: Container(
                alignment: Alignment.centerLeft,
                width: 300,
                height: 51,
                child: Column(children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    alignment: Alignment.centerLeft,
                    height: 25,
                    width: double.infinity,
                    child: Text(
                      date,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    color: Colors.blue,
                    height: 1,
                    width: 300,
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    alignment: Alignment.centerLeft,
                    height: 25,
                    width: double.infinity,
                    child: Text(
                      details,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ]),
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                alignment: Alignment.centerLeft,
                width: 100,
                height: 51,
                child: Column(children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    alignment: Alignment.centerLeft,
                    height: 25,
                    width: double.infinity,
                    child: Text(
                      time,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    color: Colors.blue,
                    height: 1,
                    width: 100,
                  ),
                  Container(
                    padding: const EdgeInsets.all(3),
                    alignment: Alignment.centerLeft,
                    height: 25,
                    width: double.infinity,
                    child: Text(
                      type,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ]),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                alignment: Alignment.centerRight,
                width: 50,
                height: 50,
                child: CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: TextButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
