import 'package:flutter/material.dart';

import '../../load_settings.dart';
import '../../path_privider_lib.dart';

mixin Edit {
  final TextEditingController x_txt = TextEditingController();
  final TextEditingController y_txt = TextEditingController();
  final TextEditingController z_txt = TextEditingController();

  int fix_point = 1;

  void OnCancel(ref) {
    //close entity editor
    int dirId = ref.read(path_directory_id_provider);
    ref.watch(show_creator_provider.notifier).set(false);
    ref
        .read(path_entity_provider.notifier)
        .remove_object(dirId, 0);
    ref.read(path_directory_lock_provider.notifier);
    ref
        .read(path_directory_lock_provider.notifier)
        .set(false);
    if (hide_model_creation_window) {
      ref.read(show_model_provider.notifier).set(true);
    }
  }

  void OnConfirm(ref, NewObject) {
    //save data to data structure in provider
    int dirId = ref.read(path_directory_id_provider);
    int objId = ref
        .read(path_entity_provider.notifier)
        .get_new_obj_id(dirId);

    ref.read(path_entity_provider.notifier).new_object(
        dirId,
        objId,
        NewObject);

    //close entity edit window
    ref.watch(show_creator_provider.notifier).set(false);
    ref
        .read(path_entity_provider.notifier)
        .remove_object(dirId, 0);
    ref
        .read(path_directory_lock_provider.notifier)
        .set(false);
    if (hide_model_creation_window) {
      ref.read(show_model_provider.notifier).set(true);
    }
  }

}