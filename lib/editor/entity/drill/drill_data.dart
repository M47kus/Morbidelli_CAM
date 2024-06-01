import 'package:flutter/material.dart';
import 'package:morbidelli_cam/bar/drill/drill_class.dart';

import '../base/data.dart';
import 'drill_info.dart';

class DrillData extends Data {
  int id;
  Drill? drill;

  DrillData({
    this.drill,
    required this.id,
  });

  Widget getInfoButton(keyId, selectFunction) {
    return DrillInfo(id: id, key: Key("$keyId"),selectFunction: selectFunction,);
  }
}
