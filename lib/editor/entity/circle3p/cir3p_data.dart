import 'package:flutter/material.dart';
import 'package:morbidelli_cam/bar/files/settings/load_settings.dart';
import 'package:morbidelli_cam/helper/extensions/parse_internal_var.dart';

import '../../../provider/global.dart';
import '../base/data.dart';
import 'cir3p_edit.dart';
import 'cir3p_info.dart';

class Cir3PData extends Data {
  int id;
  @override
  String? x;
  @override
  String? y;
  @override
  String? z;
  String? xp;
  String? yp;
  String? zp;
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
    double dx = modelDX;
    if (xp.parseInternalVar() != null) {
      switch (fixp) {
        case 1 || 4 || 7:
          return xp.parseInternalVar();
        case 2 || 5 || 8:
          return xp.parseInternalVar()! + dx / 2;
        case 3 || 6 || 9:
          return dx - xp.parseInternalVar()!;
      }
    }
  }

  convertYP() {
    double dy = modelDY;
    if (yp.parseInternalVar() != null) {
      switch (fixp) {
        case 1 || 2 || 3:
          return yp.parseInternalVar();
        case 4 || 5 || 6:
          return yp.parseInternalVar()! + dy / 2;
        case 7 || 8 || 9:
          return dy - yp.parseInternalVar()!;
      }
    }
  }

  String getXXLData() {
    return "\nXA3P x=${convertX()} y=${convertY()} H=$z X=${convertXP()} Y=${convertYP()} Z=$zp";
  }
}
