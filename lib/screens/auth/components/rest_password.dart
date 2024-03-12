import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});
  final _emailTextController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ResetPassword',
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        margin: const EdgeInsets.all(15),
        child: Form(
            key: _formKey,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Required*'),
                      EmailValidator(errorText: 'Enter you valide Email')
                    ]).call,
                    controller: _emailTextController,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.blueAccent,
                        ),
                      ),
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      labelText: 'Email',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(2),
                    overlayColor: MaterialStateProperty.all(Colors.black12),
                    shadowColor: MaterialStateProperty.all(Colors.pink.shade50),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    fixedSize: MaterialStateProperty.all(const Size(400, 55)),
                  ),
                  onPressed: () {
                    FirebaseAuth.instance
                        .sendPasswordResetEmail(
                            email: _emailTextController.text)
                        .onError((error, stackTrace) {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text(
                            "Alert",
                            style: TextStyle(color: Colors.red, fontSize: 25),
                            textAlign: TextAlign.center,
                          ),
                          content: const Text("Your address Email is empty! \n or it's not validate "),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                color: Colors.grey[300],
                                padding: const EdgeInsets.all(14),
                                child: const Text("Ok"),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).then((value) {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("We have send you e-mail on :"),
                            content: Text(_emailTextController.text),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    color: Colors.grey[300],
                                    padding: const EdgeInsets.all(14),
                                    child: const Text("Ok"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ).then((value) => Navigator.of(context).pop());
                      }
                    });
                  },
                  child: const Text(
                    'Reset',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
