import 'package:morbidelli_cam/bar/files/settings/load_settings.dart';
import 'package:morbidelli_cam/editor/data_parse.dart';

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

  modelX(axis) {
    double scale = double.parse(modelScaleUnit.text);
    double dx = double.parse(modelDX.text);
    double convertx = convertX();

    double offset = dx / scale;
    switch (axis) {
      case LineAxis.x:
        return 0 / scale * 2 - offset;
      case LineAxis.xr:
        return dx / scale * 2 - offset;
      default:
        return convertx / scale * 2 - offset;
    }
  }

  modelY(axis) {
    double scale = double.parse(modelScaleUnit.text);
    double dy = double.parse(modelDY.text);
    double converty = convertY();

    double offset = dy / scale;
    switch (axis) {
      case LineAxis.y:
        return 0 / scale * 2 - 0 / scale * 2 - offset;
      default:
        return dy / scale * 2 - converty / scale * 2 - offset;
    }
  }

  modelZ(axis) {
    double scale = double.parse(modelScaleUnit.text);
    double dz = double.parse(modelDZ.text);

    double offset = dz / scale;
    switch (axis) {
      case LineAxis.z:
        return (dz - 0 / (scale * 2 - z!)) / scale * 2 - offset;
      default:
        return dz / scale * 2 - z! / scale * 2 - offset;
    }
  }
}
