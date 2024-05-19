import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:morbidelli_cam/bar/files/settings/save_settings.dart";
import "package:yaml/yaml.dart";

import '../../drill/drill_class.dart';

final TextEditingController modelScaleUnit = TextEditingController(text: "X");
final TextEditingController modelDX = TextEditingController(text: "X");
final TextEditingController modelDY = TextEditingController(text: "X");
final TextEditingController modelDZ = TextEditingController(text: "X");
TextEditingController defaultDX = TextEditingController();
TextEditingController defaultDY = TextEditingController();
TextEditingController defaultDZ = TextEditingController();
TextEditingController circleTMin = TextEditingController();

double importDepth = 1.0;
Drill? importDrill;
double importDetail = 16;

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
  modelDX.text = mapData["model"]["dx"].toString();
  modelDY.text = mapData["model"]["dy"].toString();
  modelDZ.text = mapData["model"]["dz"].toString();
  defaultDX.text = mapData["model"]["dx"].toString();
  defaultDY.text = mapData["model"]["dy"].toString();
  defaultDZ.text = mapData["model"]["dz"].toString();

  modelScaleUnit.text = mapData["model"]["scale"].toString();
  importDetail = mapData["svg"]["detail"];
  importDepth = mapData["svg"]["depth"];
  circleTMin.text = mapData["editor"]["circleTMin"].toString();
}
