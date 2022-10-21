import 'package:flutter/material.dart';
import '../../caseDetails/case_details.dart';

class MyCard extends StatelessWidget {
  final String id;
  final String code;
  final String year;
  final String loyerName;
  final String typeOfCase;
  final String court;
  final String circule;
  final String details;
  const MyCard({
    Key? key,
    required this.id,
    required this.code,
    required this.year,
    required this.loyerName,
    required this.typeOfCase,
    required this.court,
    required this.circule,
    required this.details,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      //color: Colors.blue.withOpacity(0.3),
      elevation: 5,
      margin: const EdgeInsets.all(5),
      surfaceTintColor: Colors.green,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        color: Colors.blue.withOpacity(0.5),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$code/$year',
                      ),
                      Text(
                        'Lawyer : $loyerName',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ListTile(
                    title: Text(
                      typeOfCase,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.arrow_forward,
                        size: 20,
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CaseDetails(
                            id: id,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text('Court : $court'),
                ),
                Expanded(
                  child: Text('Circule : $circule'),
                ),
              ],
            ),
            SizedBox(
              height: 20,
              width: double.infinity,
              //color: Colors.red,
              child: Text(details, textAlign: TextAlign.start),
            ),
          ],
        ),
      ),
    );
  }
}
