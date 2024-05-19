import 'package:flutter/material.dart';
import 'package:morbidelli_cam/editor/entity/initial/init_data.dart';
import 'package:morbidelli_cam/editor/entity/initial/init_edit.dart';

import 'entity/circle3p/cir3p_data.dart';
import 'entity/circle3p/cir3p_edit.dart';
import 'entity/drill/drill_data.dart';
import 'entity/drill/drill_edit.dart';
import 'entity/g0/go_data.dart';
import 'entity/g0/go_edit.dart';
import 'entity/g1/g1_data.dart';
import 'entity/g1/g1_edit.dart';

Widget buildEditWindow(type) {
  bool isNew = false;
  if (type != null) {
    if (type.id == 0) {
      isNew = true;
    }
  }

  if (type is G0Data) {
    return G0Creator(
      x: type.x,
      y: type.y,
      z: type.z,
      fix: type.fix,
      correction: type.correct,
      isNew: isNew,
    );
  } else if (type is G1Data) {
    return G1Creator(
      x: type.x,
      y: type.y,
      z: type.z,
      fix: type.fix,
      isNew: isNew,
    );
  } else if (type is DrillData) {
    return DrillCreator(
      drill: type.drill,
      isNew: isNew,
    );
  } else if (type is Cir3PData) {
    return Cir3PCreator(
      x: type.x,
      y: type.y,
      z: type.z,
      xp: type.xp,
      yp: type.yp,
      zp: type.zp,
      fix: type.fix,
      fixp: type.fixp,
      rotation: type.rotation,
      isNew: isNew,
    );
  } else if (type is InitData) {
    return InitCreator(
      x: type.x,
      y: type.y,
      z: type.z,
      bx: type.bx,
      by: type.by,
      bz: type.bz,
      isNew: isNew,
    );
  } else {
    return const G0Creator();
  }
}
