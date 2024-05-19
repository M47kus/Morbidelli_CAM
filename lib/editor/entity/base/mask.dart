import 'package:flutter/material.dart';
import 'package:morbidelli_cam/editor/data_parse.dart';
import 'package:morbidelli_cam/provider/path_privider_lib.dart';

mixin Mask {
  void onTab(ref, widget) {
    //create new empty entity in data structure
    ref.read(entityProvider.notifier).newObject(0, widget);
    ref.read(pathObjectIdProvider.notifier).set(0);
    ref.watch(showCreatorProvider.notifier).set(true);
  }

  Widget pathMask({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox.fromSize(
        size: const Size(55, 55),
        child: ClipOval(
          child: Material(child: child),
        ),
      ),
    );
  }
}
