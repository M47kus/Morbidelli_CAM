import 'package:flutter/material.dart';

import '../../load_settings.dart';
import '../../path_privider_lib.dart';

mixin Edit {
  final TextEditingController xtxt = TextEditingController();
  final TextEditingController ytxt = TextEditingController();
  final TextEditingController ztxt = TextEditingController();

  int fixpoint = 1;

  void onCancel(ref) {
    //close entity editor
    int dirId = ref.read(pathDirectoryIdProvider);
    ref.watch(showCreatorProvider.notifier).set(false);
    ref.read(pathEntityProvider.notifier).removeObject(dirId, 0);
    ref.read(pathDirectoryLockProvider.notifier);
    ref.read(pathDirectoryLockProvider.notifier).set(false);
    if (hideModelInCreation) {
      ref.read(showModelProvider.notifier).set(true);
    }
  }

  void onConfirm(ref, newObject) {
    //save data to data structure in provider
    int dirId = ref.read(pathDirectoryIdProvider);
    int objId = ref.read(pathEntityProvider.notifier).getNewObjId(dirId);

    ref.read(pathEntityProvider.notifier).newObject(dirId, objId, newObject);

    //close entity edit window
    ref.watch(showCreatorProvider.notifier).set(false);
    ref.read(pathEntityProvider.notifier).removeObject(dirId, 0);
    ref.read(pathDirectoryLockProvider.notifier).set(false);
    if (hideModelInCreation) {
      ref.read(showModelProvider.notifier).set(true);
    }
  }
}
