import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextInput extends StatelessWidget {
  String? Function(dynamic)? validator;
  String? labelText;
  TextInputType textInputType;
  TextEditingController textEditingController;

  TextInput({
    Key? key,
    required this.validator,
    required this.labelText,
    required this.textInputType,
    required this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          validator:validator,
          keyboardType: textInputType,
          autovalidateMode: AutovalidateMode.always,
          controller: textEditingController,
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Colors.blueAccent,
              ),
            ),
            prefixIcon: const Icon(Icons.edit),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            labelText: labelText,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
