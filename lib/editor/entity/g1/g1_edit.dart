import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/editor/data_parse.dart';
import 'package:morbidelli_cam/editor/entity/base/edit.dart';
import 'package:morbidelli_cam/editor/widgets/origin_point.dart';
import 'package:morbidelli_cam/helper/textinput.dart';
import 'package:morbidelli_cam/provider/path_privider_lib.dart';

import 'g1_data.dart';

class G1Creator extends ConsumerStatefulWidget {
  final double? x;
  final double? y;
  final double? z;
  final int? fix;
  final bool isNew;
  const G1Creator(
      {this.x, this.y, this.z, this.fix, super.key, this.isNew = false});

  @override
  ConsumerState<G1Creator> createState() => _G1CreatorState();
}

class _G1CreatorState extends ConsumerState<G1Creator> with Edit {
  void _init() {
    xtxt.clear();
    ytxt.clear();
    ztxt.clear();

    if (widget.x != null) {
      xtxt.text = widget.x.toString();
    }
    if (widget.y != null) {
      ytxt.text = widget.y.toString();
    }
    if (widget.z != null) {
      ztxt.text = widget.z.toString();
    }

    fixpoint = widget.fix ?? 1;
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void didUpdateWidget(G1Creator oldWidget) {
    super.didUpdateWidget(oldWidget);
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildAppBar(ref, name: "G1", onCanceled: onCancel, onSaved: () {
          int dirId = ref.read(pathDirectoryIdProvider);
          int objId = ref.read(entityProvider.notifier).getNewObjId();
          //if object is already created update old object

          if (widget.isNew == false) {
            objId = ref.read(pathObjectIdProvider);
          }
          onConfirm(
              ref,
              objId,
              G1Data(
                  id: objId,
                  x: xtxt.text == "" ? 0 : double.parse(xtxt.text),
                  y: ytxt.text == "" ? 0 : double.parse(ytxt.text),
                  z: ztxt.text == "" ? 0 : double.parse(ztxt.text),
                  fix: fixpoint));
        }),
        Expanded(
            child: Column(children: [
          FixPointChose(fixpoint, (state) {
            fixpoint = state;
          }),
          ConfigTextInput(label: "X", controller: xtxt),
          ConfigTextInput(label: "Y", controller: ytxt),
          ConfigTextInput(label: "Z", controller: ztxt)
        ]))
      ],
    );
  }
}
