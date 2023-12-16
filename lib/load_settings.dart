import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:yaml/yaml.dart";

final TextEditingController model_scale_unit = TextEditingController(text: "X");
final TextEditingController model_dx = TextEditingController(text: "X");
final TextEditingController model_dy = TextEditingController(text: "X");
final TextEditingController model_dz = TextEditingController(text: "X");


//load default settings from yaml file
Future<void> init_settings () async {
  final data = await rootBundle.loadString('assets/settings.yaml');
  final mapData = loadYaml(data);

  //save to TextEditingController
  model_dx.text = mapData["dx"].toString();
  model_dy.text = mapData["dy"].toString();
  model_dz.text = mapData["dz"].toString();

  model_scale_unit.text = mapData["scale"].toString();

}