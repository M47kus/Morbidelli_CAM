import 'package:flutter/material.dart';
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

  Widget getEntityData(ref, id, name) {
    var entity =
        ref.read(entityProvider)[ref.watch(pathDirectoryIdProvider)]![id];

    return ListTile(
      title: Text(name),
      trailing: Text(
          "${entity.convertX() ?? ""}   ${entity.convertY() ?? ""}   ${entity.z ?? ""}"),
    );
  }
}
