import 'package:flutter/material.dart';

import '../../load_settings.dart';
import '../../path_privider_lib.dart';

mixin Mask {
  void OnTab(ref, widget) {
    //create new empty entity in data structure
    int dirId = ref.read(path_directory_id_provider);
    ref.read(path_entity_provider.notifier).new_object(dirId, 0, widget);
    ref.read(path_object_id_provider.notifier).set(0);
    ref.watch(show_creator_provider.notifier).set(true);
    //disable directory buttons
    ref.read(path_directory_lock_provider.notifier).set(true);
    if (hide_model_creation_window)
      ref.read(show_model_provider.notifier).set(false);
  }

  Widget PathMask({required Widget child}) {
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
