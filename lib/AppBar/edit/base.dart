import 'package:flutter/material.dart';
import 'package:morbidelli_cam/helper/textinput.dart';

final TextEditingController model_dx = TextEditingController(text: "19");

class Edit_Base extends StatefulWidget {
  const Edit_Base({super.key});

  @override
  State<Edit_Base> createState() => _Edit_BaseState();
}

class _Edit_BaseState extends State<Edit_Base> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Base Plate",
        style: TextStyle(fontSize: 18),
      )),
      body: Column(
        children: [ConfigTextInput(label: "DX", controller: model_dx)],
      ),
    );
  }
}
