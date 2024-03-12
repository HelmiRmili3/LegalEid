import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../components/section.dart';
import 'package:firebase_auth/firebase_auth.dart';


class GridSection extends StatefulWidget {
  const GridSection({super.key});
  @override
  State<GridSection> createState() => _GridSectionState();
}

class _GridSectionState extends State<GridSection> {
  int caseNumber = 0,
      consultationsNumber = 0,
      sessionsNumber = 0,
      totalAmounts = 0,
      totalPayments = 0,
      remains = 0;
  //read data from firebase firestor for the current user
  Future<void> _fetch() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    if (uid.isNotEmpty) {
    await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get()
          .then((snapshot) => {
                caseNumber = snapshot.get('caseNumber'),
                consultationsNumber = snapshot.get('consultationsNumber'),
                sessionsNumber = snapshot.get('sessionsNumber'),
                totalAmounts = snapshot.get('totalAmounts'),
                totalPayments = snapshot.get('totalPayments'),
                remains = totalAmounts - totalPayments,
              });
    }
  }

  @override
  Widget build(BuildContext context) {
    _fetch();
    return FutureBuilder(
        future: _fetch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SizedBox(
              height: 300,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Section(
                            title: 'case(s) Number',
                            value: caseNumber,
                            headercolor: Colors.green),
                        const SizedBox(width: 10),
                        Section(
                            title: 'Consultation(s)',
                            value: consultationsNumber,
                            headercolor: Colors.green),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Row(
                      children: [
                        Section(
                            title: 'Session(s) Number',
                            value: sessionsNumber,
                            headercolor: Colors.white),
                        const SizedBox(width: 10),
                        Section(
                            title: 'Total Amounts',
                            value: totalAmounts,
                            headercolor: Colors.red),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Row(
                      children: [
                        Section(
                            title: 'Payments',
                            value: totalPayments,
                            headercolor: Colors.green),
                        const SizedBox(width: 10),
                        Section(
                            title: 'Remains',
                            value: remains,
                            headercolor: Colors.green),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          } else {
            return const SizedBox(
              height: 300,
              child:  Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
