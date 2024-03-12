import 'package:flutter/material.dart';

class CostomField extends StatelessWidget {
  final String text;
  CostomField({
    super.key,
    required this.text,
  });
  final _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //focusNode:myFocusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: _emailTextController,
      decoration: const InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Colors.blueAccent,
          ),
        ),
        prefixIcon: Icon(Icons.edit),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        labelText: 'text',
      ),
    );
  }
}
