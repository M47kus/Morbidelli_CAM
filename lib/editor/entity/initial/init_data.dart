import 'package:flutter/material.dart';

import '../base/data.dart';
import 'init_info.dart';

class InitData extends Data {
  int id;
  @override
  String? x;
  @override
  String? y;
  @override
  String? z;

  String? bx;
  String? by;
  String? bz;

  @override
  InitData(
      {required this.id, this.x, this.y, this.z, this.bx, this.by, this.bz});

  Widget getInfoButton(keyId, selectFunction) {
    return InitInfo(
      id: id,
      key: Key("$keyId"),selectFunction: selectFunction,
    );
  }

  String getXXLData(drill) {
    return "\nXG0 X=${convertX()} Y=${convertY()} Z=$z T=${drill.id}";
  }
}
