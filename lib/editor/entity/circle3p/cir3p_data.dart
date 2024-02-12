import 'package:flutter/material.dart';
import 'package:morbidelli_cam/bar/files/settings/load_settings.dart';
import 'package:morbidelli_cam/editor/data_parse.dart';

import '../base/data.dart';
import 'cir3p_edit.dart';
import 'cir3p_info.dart';

class Cir3PData extends Data {
  int id;
  @override
  double? x;
  @override
  double? y;
  @override
  double? z;
  double? xp;
  double? yp;
  double? zp;
  @override
  int? fix;
  int? fixp;
  Cir3PAxisRotation? rotation;

  Cir3PData(
      {required this.id,
      this.x,
      this.y,
      this.z,
      this.xp,
      this.yp,
      this.zp,
      this.fix,
      this.fixp,
      this.rotation});

  Widget getInfoButton() {
    return Cir3PInfo(id: id);
  }

  convertXP() {
    double dx = double.parse(modelDX.text);
    if (xp != null) {
      switch (fixp) {
        case 1 || 4 || 7:
          return xp;
        case 2 || 5 || 8:
          return xp! + dx / 2;
        case 3 || 6 || 9:
          return dx - xp!;
      }
    }
  }

  convertYP() {
    double dy = double.parse(modelDY.text);
    if (yp != null) {
      switch (fixp) {
        case 1 || 2 || 3:
          return yp;
        case 4 || 5 || 6:
          return yp! + dy / 2;
        case 7 || 8 || 9:
          return dy - yp!;
      }
    }
  }

  modelXP(axis) {
    double scale = double.parse(modelScaleUnit.text);
    double dx = double.parse(modelDX.text);
    double convertx = convertXP();

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

  modelYP(axis) {
    double scale = double.parse(modelScaleUnit.text);
    double dy = double.parse(modelDY.text);
    double converty = convertYP();

    double offset = dy / scale;
    switch (axis) {
      case LineAxis.y:
        return 0 / scale * 2 - 0 / scale * 2 - offset;
      default:
        return dy / scale * 2 - converty / scale * 2 - offset;
    }
  }

  modelZP(axis) {
    double scale = double.parse(modelScaleUnit.text);
    double dz = double.parse(modelDZ.text);

    double offset = dz / scale;
    switch (axis) {
      case LineAxis.z:
        return (dz - 0 / (scale * 2 - zp!)) / scale * 2 - offset;
      default:
        return dz / scale * 2 - zp! / scale * 2 - offset;
    }
  }
}
