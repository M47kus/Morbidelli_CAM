import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/bar/drill/drill_class.dart';
import 'package:morbidelli_cam/editor/data_parse.dart';

import '../base/data.dart';
import 'drill_info.dart';

class DrillData extends Data {
  int id;
  Drill? drill;

  DrillData({
    this.drill,
    required this.id,
  });

  Widget getInfoButton(keyId) {
    return DrillInfo(id: id, key: Key("$keyId"),);
  }
}
