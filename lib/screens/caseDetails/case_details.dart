import 'package:flutter/material.dart';
import '../caseDetails/components/info.dart';

class CaseDetails extends StatelessWidget {
  static String routeName = "/caseDetails";
  final String id;
  const CaseDetails({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Case Details'),
          centerTitle: true,
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
