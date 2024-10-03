import 'package:flutter/material.dart';
import 'package:morbidelli_cam/bar/drill/drill_class.dart';

import '../base/data.dart';
import 'group_info.dart';

class GroupData extends Data {
  int id;
  List? entitys;

  GroupData({
    this.entitys,
    required this.id,
  });

  Widget getInfoButton(keyId, selectFunction) {
    return GroupInfo(id: id, key: Key("$keyId"),selectFunction: selectFunction, entitys: entitys,);
  }
}
