import "dart:io";
import 'package:yaml_writer/yaml_writer.dart';

//create new yaml config from Drill class and changed settings
Map updateDrill(
    {required drillbuttonClass,
    required name,
    required d,
    required l,
    required form,
    dt,
    a}) {
  Map drillFile = {};

  for (int i = 0; i < drillbuttonClass.length; i++) {
    if (drillbuttonClass[i].name == name) {
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
      drillFile[drillbuttonClass[i].name] = {};
      drillFile[drillbuttonClass[i].name]["d"] = drillbuttonClass[i].d;
      drillFile[drillbuttonClass[i].name]["l"] = drillbuttonClass[i].l;
      drillFile[drillbuttonClass[i].name]["form"] = drillbuttonClass[i].form;
      drillFile[drillbuttonClass[i].name]["dt"] = drillbuttonClass[i].dt;
      drillFile[drillbuttonClass[i].name]["a"] = drillbuttonClass[i].a;
    }
  }

  //convert to yaml string
  var yamlWriter = YAMLWriter();
  var yamlDocString = yamlWriter.write(drillFile);

  //write to file
  File('assets/drills.yaml').writeAsString(yamlDocString);
  return drillFile; //return Map
}
