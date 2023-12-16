import 'package:flutter/material.dart';
import 'package:morbidelli_cam/load_settings.dart';
import '../../helper/textinput.dart';

//Settings Navigation
//use of TextEditingController
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
                label: "Scale Unit obj import", controller: model_scale_unit),
          ],
        ));
  }
}
