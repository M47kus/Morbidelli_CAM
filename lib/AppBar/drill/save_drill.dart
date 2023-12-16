import "dart:io";
import 'package:yaml_writer/yaml_writer.dart';

//create new yaml config from Drill class and changed settings
Map update_drill(
    {required drill_button_class,
    required name,
    required d,
    required l,
    required form,
    dt,
    a}) {
  Map drillFile = {};

  for (int i = 0; i < drill_button_class.length; i++) {
    if (drill_button_class[i].name == name) {
      //Map changed data
      drillFile[name] = {};
      drillFile[name]["d"] = double.parse(d);
      drillFile[name]["l"] = double.parse(l);
      drillFile[name]["form"] = form;
      if (dt != null && dt != "null") {
        drillFile[name]["dt"] = double.parse(dt);
      }
      if (a != null && dt != "null") {
        drillFile[name]["a"] = double.parse(a);
      }
    } else {
      //Map original Data
      drillFile[drill_button_class[i].name] = {};
      drillFile[drill_button_class[i].name]["d"] = drill_button_class[i].d;
      drillFile[drill_button_class[i].name]["l"] = drill_button_class[i].l;
      drillFile[drill_button_class[i].name]["form"] =
          drill_button_class[i].form;
      drillFile[drill_button_class[i].name]["dt"] = drill_button_class[i].dt;
      drillFile[drill_button_class[i].name]["a"] = drill_button_class[i].a;
    }
  }

  //convert to yaml string
  var yamlWriter = YAMLWriter();
  var yamlDocString = yamlWriter.write(drillFile);

  //write to file
  File('assets/drills.yaml').writeAsString(yamlDocString);
  return drillFile; //return Map
}
