import "package:flutter/services.dart";
import "package:morbidelli_cam/bar/files/settings/save_settings.dart";
import "package:yaml/yaml.dart";

import "../../../provider/global.dart";

//load default settings from yaml file
Future<void> initSettings() async {
  final data = await rootBundle.loadString('assets/settings.yaml');
  final mapData = loadYaml(data);

  //loadData(mapData);
  try {
    loadData(mapData);
  } catch (error) {
    print("Can not load settings: $error");
    //reset to default
    saveDefaultSettings();
    final data = await rootBundle.loadString('assets/settings.yaml');
    final mapData = loadYaml(data);
    loadData(mapData);
  }
}

void loadData(mapData) {
  modelDX = mapData["model"]["dx"].toDouble();
  modelDY = mapData["model"]["dy"].toDouble();
  modelDZ = mapData["model"]["dz"].toDouble();
  defaultDX.text = mapData["model"]["dx"].toString();
  defaultDY.text = mapData["model"]["dy"].toString();
  defaultDZ.text = mapData["model"]["dz"].toString();

  modelScaleUnit.text = mapData["model"]["scale"].toString();
  importDetail = mapData["svg"]["detail"];
  importDepth = mapData["svg"]["depth"];
  circleTMin.text = mapData["editor"]["circleTMin"].toString();
}
