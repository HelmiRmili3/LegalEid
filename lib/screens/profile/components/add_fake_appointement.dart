import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:intl/intl.dart';

class AddFakeAppointement extends StatefulWidget {
  const AddFakeAppointement({Key? key}) : super(key: key);

  @override
  State<AddFakeAppointement> createState() => _AddFakeAppointementState();
}

class _AddFakeAppointementState extends State<AddFakeAppointement> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final dateTimTextController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isLoding = false;
  var consultations = 0;
  TextEditingController detailsTextController = TextEditingController();
  String date = DateFormat.yMd().format(DateTime.now());
  String time = DateFormat.Hm().format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add fake appointement'),
        actions: [
          IconButton(
            onPressed: () async {
              setState(() {
                isLoding = !isLoding;
              });
              final caseId = FirebaseFirestore.instance
                  .collection('data')
                  .doc(uid)
                  .collection('appointements')
                  .doc()
                  .id;
              await FirebaseFirestore.instance
                  .collection('data')
                  .doc(uid)
                  .collection('appointements')
                  .doc(caseId)
                  .set({
                'id': caseId,
                'date': date,
                'time': time,
                'details': detailsTextController.text,
              });
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(uid)
                  .get()
                  .then((oldvalue) {
                setState(() {
                  consultations = oldvalue['consultationsNumber'];
                });
              });
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(uid)
                  .update({
                'consultationsNumber': consultations + 1,
              }).then((value) {
                setState(() {
                  isLoding = !isLoding;
                });
                Navigator.pop(context);
                dispose();
              });    
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: isLoding
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(20),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      DateTimePicker(
                        type: DateTimePickerType.dateTimeSeparate,
                        dateMask: 'd MMM, yyyy',
                        initialValue: DateTime.now().toString(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        icon: const Icon(Icons.event),
                        dateLabelText: 'Date',
                        timeLabelText: "Hour",
                        onChanged: (val) {
                          setState(() {
                            date = DateFormat.yMd(val).toString();
                            time = DateFormat.Hm(val).toString();
                          });
                        },
                        validator: null,
                        onSaved: null,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return 'Note is empty';
                          }
                          return null;
                        }),
                        maxLines: 8,
                        controller: detailsTextController,
                        decoration: const InputDecoration(
                          hintText: 'Write your detaild text in here .',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.blueAccent,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
    );
  }
}
