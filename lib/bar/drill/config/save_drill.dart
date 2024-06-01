import "dart:io";
import 'package:yaml_writer/yaml_writer.dart';

//create new yaml config from Drill class and changed settings
Map updateDrill(
    {required drillbuttonClass,
    required name,
      required id,
    required d,
    required l,
    required form,
    dt,
    a}) {
  Map drillFile = {};

  for (int i = 0; i < drillbuttonClass.length; i++) {
    if (drillbuttonClass.values
        .toList()[i].name == name) {
      //Map changed data
      drillFile[name] = {};
      drillFile[name]["id"] = int.parse(id);
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
      drillFile[drillbuttonClass.values.toList()[i].name] = {};
      drillFile[drillbuttonClass.values.toList()[i].name]["id"] = drillbuttonClass.values.toList()[i].id;
      drillFile[drillbuttonClass.values.toList()[i].name]["d"] = drillbuttonClass.values.toList()[i].d;
      drillFile[drillbuttonClass.values.toList()[i].name]["l"] = drillbuttonClass.values.toList()[i].l;
      drillFile[drillbuttonClass.values.toList()[i].name]["form"] = drillbuttonClass.values.toList()[i].form;
      drillFile[drillbuttonClass.values.toList()[i].name]["dt"] = drillbuttonClass.values.toList()[i].dt;
      drillFile[drillbuttonClass.values.toList()[i].name]["a"] = drillbuttonClass.values.toList()[i].a;
    }
  }

  //convert to yaml string
  var yamlWriter = YAMLWriter();
  var yamlDocString = yamlWriter.write(drillFile);

  //write to file
  File('assets/drills.yaml').writeAsString(yamlDocString);
  return drillFile; //return Map
}
