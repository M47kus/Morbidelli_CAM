import 'package:morbidelli_cam/editor/data_parse.dart';
import 'package:vector_math/vector_math_64.dart';

import '../../provider/global.dart';

extension ModelLine on Vector3 {
  model(axis) {
    double scale = double.parse(modelScaleUnit.text);
    double dx = modelDX;
    double offsetx = dx / scale;
    double dy = modelDY;
    double offsety = dy / scale;
    double dz = modelDZ;
    double offsetz = dz / scale;

    Vector3 newVector = Vector3(0, 0, 0);

    switch (axis) {
      case LineAxis.x:
        newVector.x = 0 / scale * 2 - offsetx;
      case LineAxis.xr:
        newVector.x = dx / scale * 2 - offsetx;
      default:
        newVector.x = x / scale * 2 - offsetx;
    }

    switch (axis) {
      case LineAxis.y:
        newVector.z = 0 / scale * 2 - 0 / scale * 2 - offsety;
      default:
        newVector.z = dy / scale * 2 - z / scale * 2 - offsety;
    }

    switch (axis) {
      case LineAxis.z:
        newVector.y = (dz - 0 / (scale * 2 - y)) / scale * 2 - offsetz;
      default:
        newVector.y = dz / scale * 2 - y / scale * 2 - offsetz;
    }
    return newVector;
  }
}