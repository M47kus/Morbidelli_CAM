import 'package:flutter/material.dart';
import 'package:morbidelli_cam/edit_overlay/g0/go_edit.dart';
import 'package:morbidelli_cam/edit_overlay/g1/g1_edit.dart';

import '../drill/drill_edit.dart';

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
  } else {
    return const G0Creator();
  }
}
