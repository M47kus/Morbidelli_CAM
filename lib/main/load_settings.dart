import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:yaml/yaml.dart";

final TextEditingController modelScaleUnit = TextEditingController(text: "X");
final TextEditingController modelDX = TextEditingController(text: "X");
final TextEditingController modelDY = TextEditingController(text: "X");
final TextEditingController modelDZ = TextEditingController(text: "X");
bool initShowDefaultModel = false;
double importDepth = 1.0;

//load default settings from yaml file
Future<void> initSettings() async {
  final data = await rootBundle.loadString('assets/settings.yaml');
  final mapData = loadYaml(data);

  //save to TextEditingController
  modelDX.text = mapData["dx"].toString();
  modelDY.text = mapData["dy"].toString();
  modelDZ.text = mapData["dz"].toString();

  modelScaleUnit.text = mapData["scale"].toString();

  initShowDefaultModel = mapData["initialDefaultModel"];
}
