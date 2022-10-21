import 'package:flutter/material.dart';

class MyForm extends StatelessWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.all(20),
      child: Form(
          child: Column(
        children: [
          TextFormField(
              //focusNode:myFocusNode,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              //controller: _emailTextController,
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
                labelText: 'Email',
              ),
            )
        ],
      )),
    );
  }
}
