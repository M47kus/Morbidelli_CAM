import 'package:flutter/material.dart';
import 'package:morbidelli_cam/edit_overlay/g0/go_edit.dart';

enum WidgetType { g0 }

Widget build_edit_window(type) {
  switch (type) {
    case WidgetType.g0:
      return G0_Creator();

    default:
      return G0_Creator();
  }
}
