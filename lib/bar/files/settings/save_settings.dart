import "dart:io";
import 'package:yaml_writer/yaml_writer.dart';

void updateSettings(
    {required modelScaleUnit,
    required dx,
    required dy,
    required dz,
    required svgDetail,
    required svgDepth,
    required circleTMin}) {
  Map settings = {};
  String model = "model";
  settings[model] = {};
  settings[model]["scale"] = modelScaleUnit;
  settings[model]["dx"] = dx;
  settings[model]["dy"] = dy;
  settings[model]["dz"] = dz;
  String svg = "svg";
  settings[svg] = {};
  settings[svg]["detail"] = svgDetail;
  settings[svg]["depth"] = svgDepth;
  String editor = "editor";
  settings[editor] = {};
  settings[editor]["circleTMin"] = circleTMin;

  //convert to yaml string
  var yamlWriter = YAMLWriter();
  var yamlDocString = yamlWriter.write(settings);

  //write to file
  File('assets/settings.yaml').writeAsString(yamlDocString);
}

//default settings
void saveDefaultSettings() {
  Map settings = {};
  String model = "model";
  settings[model] = {};
  settings[model]["scale"] = 200;
  settings[model]["dx"] = 600;
  settings[model]["dy"] = 300;
  settings[model]["dz"] = 19;
  String svg = "svg";
  settings[svg] = {};
  settings[svg]["detail"] = 16.0;
  settings[svg]["depth"] = 1.0;
  String editor = "editor";
  settings[editor] = {};
  settings[editor]["circleTMin"] = 6;

  //convert to yaml string
  var yamlWriter = YAMLWriter();
  var yamlDocString = yamlWriter.write(settings);

  //write to file
  File('assets/settings.yaml').writeAsString(yamlDocString);
}
