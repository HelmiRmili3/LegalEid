import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class AddFakePayment extends StatefulWidget {
  const AddFakePayment({super.key});

  @override
  State<AddFakePayment> createState() => _AddFakePaymentState();
}

class _AddFakePaymentState extends State<AddFakePayment> {
  bool isLoding = false;
  TextEditingController dateController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController timeTextController = TextEditingController();
  TextEditingController detailsTextController = TextEditingController();
  TextEditingController typeTextController = TextEditingController();
  @override
  void dispose() {
    dateController.dispose();
    yearController.dispose();
    timeTextController.dispose();
    detailsTextController.dispose();
    typeTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add fake payment'),
        actions: [
          IconButton(
              onPressed: () async {
                setState(() {
                  isLoding = true;
                });
                final uid =  FirebaseAuth.instance.currentUser!.uid;

                await FirebaseFirestore.instance
                    .collection('data')
                    .doc(uid)
                    .collection('payments')
                    .add({
                  'year': yearController.text,
                  'date': dateController.text,
                  'time': timeTextController.text,
                  'details': detailsTextController.text,
                  'type': typeTextController.text,
                }).then((value) {
                  setState(() {
                    isLoding = false;
                  });
                  Navigator.pop(context);
                });
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: isLoding
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(20),
              child: Form(
                child: Column(
                  children: [
                    TextField(
                        controller: dateController,
                        decoration: const InputDecoration(
                            icon: Icon(Icons.calendar_today),
                            labelText: "Enter Date"),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101));
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            String formattedyear =
                                DateFormat('yyyy').format(pickedDate);
                            setState(() {
                              yearController.text = formattedyear;
                              dateController.text = formattedDate;
                            });
                          }
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: detailsTextController,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.blueAccent,
                          ),
                        ),
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        labelText: 'Details',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: timeTextController,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.blueAccent,
                          ),
                        ),
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        labelText: 'Time',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: typeTextController,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.blueAccent,
                          ),
                        ),
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        labelText: 'Type',
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
