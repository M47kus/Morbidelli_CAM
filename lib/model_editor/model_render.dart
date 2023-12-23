import 'package:morbidelli_cam/load_settings.dart';

//create obj file from bounds
String model_base() {
  //scale down the object to fit in viewport
  //scale factor from export model programm
  double scale = double.parse(model_scale_unit.text);
  double dx = double.parse(model_dx.text);
  double dy = double.parse(model_dy.text);
  double dz = double.parse(model_dz.text);

  String v1 = "v ${-dx / scale} ${dy / scale} ${-dz / scale}\n ";
  String v2 = "v ${-dx / scale} ${dy / scale} ${dz / scale}\n ";
  String v3 = "v ${dx / scale} ${dy / scale} ${-dz / scale}\n ";
  String v4 = "v ${dx / scale} ${dy / scale} ${dz / scale}\n ";
  String v5 = "v ${-dx / scale} ${-dy / scale} ${-dz / scale}\n ";
  String v6 = "v ${-dx / scale} ${-dy / scale} ${dz / scale}\n ";
  String v7 = "v ${dx / scale} ${-dy / scale} ${-dz / scale}\n ";
  String v8 = "v ${dx / scale} ${-dy / scale} ${dz / scale}\n ";

  //default face list for cubes
  String extension =
      "s 0 \n f 1 2 4 3 \n f 3 4 8 7 \n f 7 8 6 5 \n f 5 6 2 1 \n f 3 7 5 1 \n f 8 4 2 6";

  String wavefront = v1 + v2 + v3 + v4 + v5 + v6 + v7 + v8 + extension;

  //return obj file
  return wavefront;
}
