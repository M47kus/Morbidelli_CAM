import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:morbidelli_cam/AppBar/drill/load_drill.dart";
import "package:morbidelli_cam/helper/textinput.dart";
import "package:yaml/yaml.dart";
import "dart:io";
import 'package:yaml_writer/yaml_writer.dart';


Map update_drill ({required drill_button_class, required name, required d, required l, required form, dt, a}) {
  Map drill_file = {};

  for (int i = 0; i<drill_button_class.length; i++) {

    if (drill_button_class[i].name == name) {
      drill_file[name] = {};
      drill_file[name]["d"] = double.parse(d);
      drill_file[name]["l"] = double.parse(l);
      drill_file[name]["form"] = form;
      if (dt != null && dt != "null") {drill_file[name]["dt"] = double.parse(dt);}
      if (a != null && dt != "null") {drill_file[name]["a"] = double.parse(a);}

    } else {
      drill_file[drill_button_class[i].name] = {};
      drill_file[drill_button_class[i].name]["d"] = drill_button_class[i].d;
      drill_file[drill_button_class[i].name]["l"] = drill_button_class[i].l;
      drill_file[drill_button_class[i].name]["form"] = drill_button_class[i].form;
      drill_file[drill_button_class[i].name]["dt"] = drill_button_class[i].dt;
      drill_file[drill_button_class[i].name]["a"] = drill_button_class[i].a;
    }

  }

  var yamlWriter = YAMLWriter();

  var yamlDocString = yamlWriter.write(drill_file);
  print(yamlDocString);
  File('assets/drills.yaml').writeAsString(yamlDocString);
  return drill_file;
}