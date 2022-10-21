import 'package:flutter/material.dart';
import '../caseDetails/components/info.dart';

class CaseDetails extends StatelessWidget {
  static String routeName = "/caseDetails";
  final String id;
  const CaseDetails({
    Key? key,
    required this.id,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Case Details'),
          bottom: const TabBar(tabs: [
            Tab(
              text: 'Info',
            ),
            Tab(
              text: 'Parties',
            ),
            Tab(
              text: 'Sessions',
            ),
            Tab(
              text: 'Docs',
            ),
          ]),
        ),
        body: TabBarView(
          children: [
            Info(id: id),
            const Center(
              child: Text('Empty'),
            ),
            const Center(
              child: Text('Empty'),
            ),
            const Center(
              child: Text('Empty'),
            ),
          ],
        ),
      ),
    );
  }
}
