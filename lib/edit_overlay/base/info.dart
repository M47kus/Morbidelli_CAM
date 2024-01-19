import 'package:flutter/material.dart';
import 'package:morbidelli_cam/edit_overlay/drill/drill_edit.dart';
import '../../editor_functions/data_parse.dart';
import '../../main/load_settings.dart';
import '../../provider/path_privider_lib.dart';

mixin Info {
  void onTab(ref, id) {
    //set object_id provider to new active id
    ref.read(pathObjectIdProvider.notifier).set(id);
    ref.watch(showCreatorProvider.notifier).set(true);

    //disable directory buttons
    ref.read(pathDirectoryLockProvider.notifier).set(true);
    if (hideModelInCreation) {
      ref.read(showModelProvider.notifier).set(false);
    }
  }

  String _getEntityText(entity) {
    if (entity is DrillData) {
      if (entity.drill != null) {
        return entity.drill!.name;
      } else {
        return "";
      }
    } else {
      return "${entity.convertX() ?? ""}   ${entity.convertY() ?? ""}   ${entity.z ?? ""}";
    }
  }

  Widget getEntityData(ref, id, name) {
    var entity =
        ref.read(entityProvider)[ref.watch(pathDirectoryIdProvider)]![id];

    return ListTile(
      title: Text(name),
      trailing: Text(_getEntityText(entity)),
    );
  }
}
