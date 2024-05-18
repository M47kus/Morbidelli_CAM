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
    ref.watch(showCreatorProvider.notifier).set(false);
    ref.read(entityProvider.notifier).removeObject(0);
    ref.read(modelViewProvider.notifier).setTop();
  }

  void onConfirm(ref, objId, newObject) {

    //save data to data structure in provider
    ref.read(entityProvider.notifier).newObject(objId, newObject);

    //close entity edit window
    ref.watch(showCreatorProvider.notifier).set(false);
    ref.read(entityProvider.notifier).removeObject(0);
    ref.read(modelViewProvider.notifier).setTop();
  }

  void onDelete(ref) {
    //close entity editor
    int objId = ref.watch(pathObjectIdProvider);
    ref.watch(showCreatorProvider.notifier).set(false);
    ref.read(entityProvider.notifier).removeObject(objId);
    ref.read(modelViewProvider.notifier).setTop();
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
