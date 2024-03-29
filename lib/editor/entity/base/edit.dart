import 'package:flutter/material.dart';
import 'package:morbidelli_cam/editor/data_parse.dart';
import 'package:morbidelli_cam/provider/path_privider_lib.dart';
import 'package:morbidelli_cam/provider/provider_lib.dart';

mixin Edit {
  static const IconData cancelOutlined =
      IconData(0xef28, fontFamily: 'MaterialIcons');
  static const IconData checkCircleOutline =
      IconData(0xef47, fontFamily: 'MaterialIcons');
  static const IconData deleteOutlined =
      IconData(0xefa8, fontFamily: 'MaterialIcons');

  final TextEditingController xtxt = TextEditingController();
  final TextEditingController ytxt = TextEditingController();
  final TextEditingController ztxt = TextEditingController();

  int fixpoint = 1;
  int correction = 0;

  void onCancel(ref) {
    //close entity editor
    int dirId = ref.read(pathDirectoryIdProvider);
    ref.watch(showCreatorProvider.notifier).set(false);
    ref.read(entityProvider.notifier).removeObject(dirId, 0);
    ref.read(pathDirectoryLockProvider.notifier);
    ref.read(pathDirectoryLockProvider.notifier).set(false);
    ref.read(modelViewProvider.notifier).setTop();
    ref.read(showModelProvider.notifier).set(true);
  }

  void onConfirm(ref, objId, newObject) {
    int dirId = ref.read(pathDirectoryIdProvider);

    //save data to data structure in provider
    ref.read(entityProvider.notifier).newObject(dirId, objId, newObject);

    //close entity edit window
    ref.watch(showCreatorProvider.notifier).set(false);
    ref.read(entityProvider.notifier).removeObject(dirId, 0);
    ref.read(pathDirectoryLockProvider.notifier).set(false);
    ref.read(modelViewProvider.notifier).setTop();
    ref.read(showModelProvider.notifier).set(true);
  }

  void onDelete(ref) {
    //close entity editor
    int dirId = ref.read(pathDirectoryIdProvider);
    int objId = ref.watch(pathObjectIdProvider);
    ref.watch(showCreatorProvider.notifier).set(false);
    ref.read(entityProvider.notifier).removeObject(dirId, objId);
    ref.read(pathDirectoryLockProvider.notifier);
    ref.read(pathDirectoryLockProvider.notifier).set(false);
    ref.read(modelViewProvider.notifier).setTop();
    ref.read(showModelProvider.notifier).set(true);
  }

  Widget buildAppBar(ref,
      {required name, required Function onSaved, required onCanceled}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: AppBar(
        title: Text(name),
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
                onPressed: () {
                  onDelete(ref);
                },
                icon: const Icon(deleteOutlined)),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
                onPressed: () {
                  onCanceled(ref);
                },
                icon: const Icon(cancelOutlined)),
          ),
          Padding(
              //confirm
              padding: const EdgeInsets.all(4.0),
              child: IconButton(
                  onPressed: () {
                    onSaved();
                  },
                  icon: const Icon(checkCircleOutline)))
        ],
      ),
    );
  }
}
