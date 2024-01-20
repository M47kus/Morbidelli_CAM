import 'package:flutter/material.dart';

import '../../editor_functions/data_parse.dart';
import '../../main/load_settings.dart';
import '../../provider/path_privider_lib.dart';

mixin Mask {
  void onTab(ref, widget) {
    //create new empty entity in data structure
    int dirId = ref.read(pathDirectoryIdProvider);
    ref.read(entityProvider.notifier).newObject(dirId, 0, widget);
    ref.read(pathObjectIdProvider.notifier).set(0);
    ref.watch(showCreatorProvider.notifier).set(true);
    //disable directory buttons
    ref.read(pathDirectoryLockProvider.notifier).set(true);
  }

  Widget pathMask({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox.fromSize(
        size: const Size(65, 65),
        child: ClipOval(
          child: Material(child: child),
        ),
      ),
    );
  }
}
