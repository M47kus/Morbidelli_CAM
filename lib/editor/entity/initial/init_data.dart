import 'package:flutter/material.dart';

import '../base/data.dart';
import 'init_info.dart';

class InitData extends Data {
  int id;
  @override
  double? x;
  @override
  double? y;
  @override
  double? z;

  double? bx;
  double? by;
  double? bz;

  @override
  InitData({required this.id, this.x, this.y, this.z, this.bx, this.by, this.bz,});

  Widget getInfoButton() {
    return InitInfo(id: id);
  }

  String getXXLData(drill) {
    return "\nXG0 X=${convertX()} Y=${convertY()} Z=$z T=${drill.id}";
  }
}
