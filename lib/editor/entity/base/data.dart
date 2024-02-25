import 'package:morbidelli_cam/bar/files/settings/load_settings.dart';
import 'package:morbidelli_cam/editor/data_parse.dart';
import 'package:vector_math/vector_math_64.dart';

class Data {
  double? x;
  double? y;
  double? z;
  int? fix;

  convertX() {
    double dx = double.parse(modelDX.text);
    if (x != null) {
      switch (fix) {
        case 1 || 4 || 7:
          return x;
        case 2 || 5 || 8:
          return x! + dx / 2;
        case 3 || 6 || 9:
          return dx - x!;
        default:
          return x;
      }
    }
  }

  convertY() {
    double dy = double.parse(modelDY.text);
    if (y != null) {
      switch (fix) {
        case 1 || 2 || 3:
          return y;
        case 4 || 5 || 6:
          return y! + dy / 2;
        case 7 || 8 || 9:
          return dy - y!;
        default:
          return x;
      }
    }
  }
}

extension ModelLine on Vector3 {
  model(axis) {
    double scale = double.parse(modelScaleUnit.text);
    double dx = double.parse(modelDX.text);
    double offsetx = dx / scale;
    double dy = double.parse(modelDY.text);
    double offsety = dy / scale;
    double dz = double.parse(modelDZ.text);
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

  modelX(axis) {
    double scale = double.parse(modelScaleUnit.text);
    double dx = double.parse(modelDX.text);
    double convertx = x;

    double offset = dx / scale;
    switch (axis) {
      case LineAxis.x:
        return 0 / scale * 2 - offset;
      case LineAxis.xr:
        return Vector3(dx / scale * 2 - offset, y, z);
      default:
        return Vector3(convertx / scale * 2 - offset, y, z);
    }
  }

  modelY(axis) {
    double scale = double.parse(modelScaleUnit.text);
    double dy = double.parse(modelDY.text);
    double converty = y;

    double offset = dy / scale;
    switch (axis) {
      case LineAxis.y:
        return Vector3(x, y, 0 / scale * 2 - 0 / scale * 2 - offset);
      default:
        return Vector3(x, y, dy / scale * 2 - converty / scale * 2 - offset);
    }
  }

  modelZ(axis) {
    double scale = double.parse(modelScaleUnit.text);
    double dz = double.parse(modelDZ.text);

    double offset = dz / scale;
    switch (axis) {
      case LineAxis.z:
        return Vector3(x, (dz - 0 / (scale * 2 - z)) / scale * 2 - offset, z);
      default:
        return Vector3(x, dz / scale * 2 - z / scale * 2 - offset, z);
    }
  }
}
