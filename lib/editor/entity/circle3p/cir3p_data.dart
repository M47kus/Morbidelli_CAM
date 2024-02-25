import 'package:flutter/material.dart';
import 'package:morbidelli_cam/bar/files/settings/load_settings.dart';

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

  String getXXLData() {
    return "\nXA3P x=${convertX()} y=${convertY()} H=$z X=${convertXP()} Y=${convertYP()} Z=$zp";
  }
}
