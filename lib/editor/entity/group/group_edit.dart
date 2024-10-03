import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/bar/drill/drill_class.dart';
import 'package:morbidelli_cam/editor/data_parse.dart';
import 'package:morbidelli_cam/provider/path_privider_lib.dart';
import 'package:morbidelli_cam/provider/provider_lib.dart';

import '../base/edit.dart';
import 'group_data.dart';

class GroupCreator extends ConsumerStatefulWidget {
  List? entitys;
  final bool isNew;

  GroupCreator({super.key, this.isNew = false, this.entitys});

  @override
  ConsumerState<GroupCreator> createState() => _GroupCreatorState();
}

class _GroupCreatorState extends ConsumerState<GroupCreator> with Edit {
  List entitys = [];

  void _init() {
    if (widget.entitys != null) {
      entitys = widget.entitys!;
    }
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void didUpdateWidget(GroupCreator oldWidget) {
    super.didUpdateWidget(oldWidget);
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildAppBar(ref, name: "Group", onCanceled: onCancel, onSaved: () {
          int objId = ref.read(entityProvider.notifier).getNewObjId();
          //if object is already created update old objectE

          if (widget.isNew == false) {
            objId = ref.read(pathObjectIdProvider);
          }

          for (int keyId in ref.read(pathSelectedProvider)) {
            entitys.add(ref.read(entityProvider.notifier).getEntity(keyId));
            //ref.read(entityProvider.notifier).removeObject(keyId);
          }
          ref.read(pathSelectedProvider.notifier).clear();
          ref.read(pathObjectEditProvider.notifier).set(false);

          onConfirm(
              ref,
              objId,
              widget.isNew,
              GroupData(
                entitys: entitys,
                id: objId,
              ));
        }),
        Expanded(
            child: Column(children: [
          Text("Apply all selected items"),
          for(var item in entitys) Text("$item"),
        ])),
      ],
    );
  }
}
