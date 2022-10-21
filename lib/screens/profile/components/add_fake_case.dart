import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'text_input.dart';

class AddFakeCase extends StatefulWidget {
  const AddFakeCase({Key? key}) : super(key: key);
  @override
  State<AddFakeCase> createState() => _AddFakeCaseState();
}

class _AddFakeCaseState extends State<AddFakeCase> {
  int caseNumber = 0;
  int totalAmounts = 0;
  int totalPayments = 0;

  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final caseId = FirebaseFirestore.instance
        .collection('data')
        .doc(uid)
        .collection('cases')
        .doc()
        .id;
    bool isLoding = false;
    final codeTextController = TextEditingController();
    final amountTextController = TextEditingController();
    final payedTextController = TextEditingController();
    final typeTextController = TextEditingController();
    final statusTextController = TextEditingController();
    final circuleTextController = TextEditingController();
    final courtTextController = TextEditingController();
    final lawyerTextController = TextEditingController();
    final detailsTextController = TextEditingController();
    @override
    void dispose() {
      // Clean up the controller when the widget is disposed.
      codeTextController.dispose();
      amountTextController.dispose();
      payedTextController.dispose();
      typeTextController.dispose();
      statusTextController.dispose();
      circuleTextController.dispose();
      courtTextController.dispose();
      lawyerTextController.dispose();
      detailsTextController.dispose();
      _formKey.currentState!.reset();
    }

    void _clearFields() {
      // Clear the fields wen the auth state changes.
      codeTextController.clear();
      amountTextController.clear();
      payedTextController.clear();
      typeTextController.clear();
      statusTextController.clear();
      circuleTextController.clear();
      courtTextController.clear();
      lawyerTextController.clear();
      detailsTextController.clear();
    }

    Future<void> setCaseData() async {
      return await FirebaseFirestore.instance
          .collection('data')
          .doc(uid)
          .collection('cases')
          .doc(caseId)
          .set({
        'id': caseId,
        'code': int.parse(codeTextController.text),
        'amount': int.parse(amountTextController.text),
        'payed': int.parse(payedTextController.text),
        'year': DateTime.now().year.toString(),
        'type': typeTextController.text,
        'status': statusTextController.text,
        'circule': circuleTextController.text,
        'court': courtTextController.text,
        'lawyer': lawyerTextController.text,
        'details': detailsTextController.text,
      });
    }

    Future<void> getOldData() async {
      return await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get()
          .then((oldvalue) {
        setState(() {
          caseNumber = oldvalue['caseNumber'];
          totalAmounts = oldvalue['totalAmounts'];
          totalPayments = oldvalue['totalPayments'];
        });
      });
    }

    Future<void> addNewDataDashbord() async {
      return await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({
        'caseNumber': caseNumber + 1,
        'totalAmounts': totalAmounts + int.parse(amountTextController.text),
        'totalPayments': totalPayments + int.parse(payedTextController.text),
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add fake case'),
        actions: [
          IconButton(
              onPressed: () async {
                setState(() {
                  isLoding = true;
                });
                await setCaseData();
                await getOldData();
                await addNewDataDashbord().then((value) {
                  setState(() {
                    isLoding = false;
                  });
                  Navigator.pop(context);
                  _clearFields();
                  dispose();
                });
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: isLoding
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextInput(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'The field is empty';
                          } else if (value.toString().length != 5) {
                            return 'The legth of the code must be 5 .';
                          }
                          return null;
                        },
                        labelText: 'Case Code',
                        textInputType: TextInputType.number,
                        textEditingController: codeTextController,
                      ),
                      TextInput(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'The field is empty';
                          }
                          return null;
                        },
                        labelText: 'Amount (DT)',
                        textInputType: TextInputType.number,
                        textEditingController: amountTextController,
                      ),
                      TextInput(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'The field is empty';
                          }
                          return null;
                        },
                        labelText: 'Payed (DT)',
                        textInputType: TextInputType.number,
                        textEditingController: payedTextController,
                      ),
                      TextInput(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'The field is empty';
                          }
                          return null;
                        },
                        labelText: 'Type',
                        textInputType: TextInputType.text,
                        textEditingController: typeTextController,
                      ),
                      TextInput(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'The field is empty';
                          }
                          return null;
                        },
                        labelText: 'Status',
                        textInputType: TextInputType.text,
                        textEditingController: statusTextController,
                      ),
                      TextInput(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'The field is empty';
                          }
                          return null;
                        },
                        labelText: 'Circule',
                        textInputType: TextInputType.text,
                        textEditingController: circuleTextController,
                      ),
                      TextInput(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'The field is empty';
                          }
                          return null;
                        },
                        labelText: 'Court',
                        textInputType: TextInputType.text,
                        textEditingController: courtTextController,
                      ),
                      TextInput(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'The field is empty';
                          }
                          return null;
                        },
                        labelText: 'Lawyer',
                        textInputType: TextInputType.text,
                        textEditingController: lawyerTextController,
                      ),
                      TextInput(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'The field is empty';
                          }
                          return null;
                        },
                        labelText: 'Details',
                        textInputType: TextInputType.text,
                        textEditingController: detailsTextController,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
