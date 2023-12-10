import 'package:flutter/material.dart';
import 'package:morbidelli_cam/load_settings.dart';
import '../../helper/textinput.dart';

class Settings_Menu extends StatefulWidget {
  const Settings_Menu({super.key});

  @override
  State<Settings_Menu> createState() => _Settings_MenuState();
}

class _Settings_MenuState extends State<Settings_Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Settings",
            style: TextStyle(fontSize: 18),
          )),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Model:", style: TextStyle(fontSize: 16),),
          ),
          ConfigTextInput(label: "Scale Unit obj import", controller: model_scale_unit)
        ],
      )
    );
  }
}
