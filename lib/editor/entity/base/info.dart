import 'package:flutter/material.dart';
import 'package:morbidelli_cam/editor/data_parse.dart';
import 'package:morbidelli_cam/helper/extensions/parse_internal_var.dart';
import 'package:morbidelli_cam/provider/path_privider_lib.dart';

import '../../../provider/global.dart';
import '../drill/drill_data.dart';
import '../initial/init_data.dart';

mixin Info {
  void onTab(ref, id) {
    //set object_id provider to new active id
    ref.read(pathObjectIdProvider.notifier).set(id);
    ref.watch(showCreatorProvider.notifier).set(true);
  }

  double? _parseInternalVar(par) {
    double state = 0.0;
    try {
      state = double.parse(par);
    } catch (error) {
      if (globalVar.state.containsKey(this)) {
        state = globalVar.state[this]!;
      }
    }
    return state;
    }

  String _getEntityText(entity) {
    if (entity is DrillData) {
      if (entity.drill != null) {
        return entity.drill!.name;
      } else {
        return "";
      }
    } else if (entity is InitData) {
      return "${entity.x == null ? "" : num.parse(entity.x.parseInternalVar()!.toStringAsFixed(2))}  ${entity.y == null ? "" : num.parse(entity.y.parseInternalVar()!.toStringAsFixed(2))}  ${entity.z == null ? "" : num.parse(entity.z.parseInternalVar()!.toStringAsFixed(2))}";
    } else {
      if (entity.convertX() != null && entity.convertY() != null) {
        return "${num.parse(entity.convertX().toStringAsFixed(2))}  ${num.parse(entity.convertY().toStringAsFixed(2))} ${num.parse(_parseInternalVar(entity.z)!.toStringAsFixed(2))}";
      }
      return "";
    }
  }

  Widget getEntityData(
    ref,
    id,
  ) {
    var entity = ref.read(entityProvider)[id];
    return Text(_getEntityText(entity));
  }
}
