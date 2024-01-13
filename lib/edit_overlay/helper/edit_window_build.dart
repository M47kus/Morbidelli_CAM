import 'package:flutter/material.dart';
import 'package:morbidelli_cam/edit_overlay/g0/go_edit.dart';

Widget buildEditWindow(type) {
  if (type is G0Data) {
    return G0Creator(x: type.x, y: type.y, z: type.z, fix: type.fix);
  } else {
    return const G0Creator();
  }
}
