import 'package:flutter/material.dart';

class ConfigTextInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const ConfigTextInput(
      {super.key, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        onSaved: (String? value) {
          controller.text = value ?? "";
        },
        style: const TextStyle(fontSize: 15),
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
          labelStyle: const TextStyle(fontSize: 15),
          hintText: controller.text,
        ),
      ),
    );
  }
}
