import 'package:flutter/material.dart';
import 'package:morbidelli_cam/bar/files/settings/save_settings.dart';
import 'package:morbidelli_cam/helper/textinput.dart';

import '../../../provider/global.dart';

//Settings Navigation
//use of TextEditingController
class SettingsMenu extends StatefulWidget {
  const SettingsMenu({super.key});

  @override
  State<SettingsMenu> createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {
  TextEditingController svgDetail = TextEditingController();
  TextEditingController svgDepth = TextEditingController();

  @override
  void initState() {
    super.initState();
    svgDetail.text = importDetail.toString();
    svgDepth.text = importDepth.toString();
  }

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
            ConfigTextInput(
                label: "default import scale", controller: modelScaleUnit),
            ConfigTextInput(label: "defaultDX", controller: defaultDX),
            ConfigTextInput(label: "defaultDY", controller: defaultDY),
            ConfigTextInput(label: "defaultDZ", controller: defaultDZ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "SVG:",
                style: TextStyle(fontSize: 16),
              ),
            ),
            ConfigTextInput(label: "defaultDetail", controller: svgDetail),
            ConfigTextInput(label: "defaultDepth", controller: svgDepth),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Editor:",
                style: TextStyle(fontSize: 16),
              ),
            ),
            ConfigTextInput(label: "CircleTMin", controller: circleTMin),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    updateSettings(
                        modelScaleUnit: double.parse(modelScaleUnit.text),
                        dx: double.parse(defaultDX.text),
                        dy: double.parse(defaultDY.text),
                        dz: double.parse(defaultDZ.text),
                        svgDetail: double.parse(svgDetail.text),
                        svgDepth: double.parse(svgDepth.text),
                        circleTMin: int.parse(circleTMin.text));
                    Navigator.of(context).pop();

                    //load data which is not relevant for editor and has not txtEditing controller
                    importDetail = double.parse(svgDetail.text);
                    importDepth = double.parse(svgDepth.text);
                  },
                  child: const Text("Save")),
            ),
          ],
        ));
  }
}
