import 'package:flutter/material.dart';
import 'package:morbidelli_cam/main/load_settings.dart';
import '../../helper/check_button.dart';
import '../../helper/textinput.dart';

//Settings Navigation
//use of TextEditingController
class SettingsMenu extends StatefulWidget {
  const SettingsMenu({super.key});

  @override
  State<SettingsMenu> createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
          "Settings",
          style: TextStyle(fontSize: 18),
        )),
        body: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Model:",
                style: TextStyle(fontSize: 16),
              ),
            ),
            //todo: set settings save to yaml
            //todo: default setting TXTC for dxyz
            ConfigTextInput(
                label: "Scale Unit obj import", controller: modelScaleUnit),

          ],
        ));
  }
}
