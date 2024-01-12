import 'package:flutter/material.dart';
import 'package:morbidelli_cam/edit_overlay/g0/go_edit.dart';

Widget build_edit_window(type) {

  if(type is G0_Data) {

    return G0_Creator(type.x, type.y, type.z, type.fix);

  } else {

    return G0_Creator();

  }

}
