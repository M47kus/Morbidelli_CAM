import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/editor/data_parse.dart';
import 'package:morbidelli_cam/editor/entity/base/edit.dart';
import 'package:morbidelli_cam/editor/widgets/offset_corection.dart';
import 'package:morbidelli_cam/editor/widgets/origin_point.dart';
import 'package:morbidelli_cam/helper/textinput.dart';
import 'package:morbidelli_cam/provider/path_privider_lib.dart';

import 'go_data.dart';

class G0Creator extends ConsumerStatefulWidget {
  final double? x;
  final double? y;
  final double? z;
  final int? fix;
  final int? correction;
  final bool isNew;
  const G0Creator(
      {this.x,
      this.y,
      this.z,
      this.fix,
      this.correction,
      super.key,
      this.isNew = false});

  @override
  ConsumerState<G0Creator> createState() => _G0CreatorState();
}

class _G0CreatorState extends ConsumerState<G0Creator> with Edit {
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
    correction = widget.correction ?? 0;
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void didUpdateWidget(G0Creator oldWidget) {
    super.didUpdateWidget(oldWidget);
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildAppBar(ref, name: "G0", onCanceled: onCancel, onSaved: () {
          int objId = ref.read(entityProvider.notifier).getNewObjId();
          //if object is already created update old object

          if (widget.isNew == false) {
            objId = ref.read(pathObjectIdProvider);
          }
          onConfirm(
              ref,
              objId,
              G0Data(
                  id: objId,
                  x: xtxt.text == "" ? 0 : double.parse(xtxt.text),
                  y: ytxt.text == "" ? 0 : double.parse(ytxt.text),
                  z: ztxt.text == "" ? 0 : double.parse(ztxt.text),
                  fix: fixpoint,
                  correct: correction));
        }),
        Expanded(
            child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FixPointChose(fixpoint, (state) {
                fixpoint = state;
              }),
              DrillCorrection(
                data: correction,
                returnvalue: (data) {
                  setState(() {
                    correction = data;
                  });
                },
              )
            ],
          ),
          ConfigTextInput(label: "X", controller: xtxt),
          ConfigTextInput(label: "Y", controller: ytxt),
          ConfigTextInput(label: "Z", controller: ztxt)
        ]))
      ],
    );
  }
}
