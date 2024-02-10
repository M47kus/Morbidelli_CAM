import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/edit_overlay/g0/go_info.dart';
import 'package:morbidelli_cam/edit_overlay/helper/offset_corection.dart';
import 'package:morbidelli_cam/helper/textinput.dart';

import '../../editor_functions/data_parse.dart';
import '../../provider/path_privider_lib.dart';
import '../base/edit.dart';
import '../helper/data.dart';
import '../helper/origin_point.dart';

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
          int dirId = ref.read(pathDirectoryIdProvider);
          int objId = ref.read(entityProvider.notifier).getNewObjId(dirId);
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
                  y: xtxt.text == "" ? 0 : double.parse(ytxt.text),
                  z: xtxt.text == "" ? 0 : double.parse(ztxt.text),
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

class G0Data extends Data {
  int id;
  int? correct;
  @override
  double? x;
  @override
  double? y;
  @override
  double? z;
  @override
  int? fix;
  G0Data({required this.id, this.x, this.y, this.z, this.fix, this.correct});

  Widget getInfoButton() {
    return G0Info(id: id);
  }

  String getXXLData(drill) {
    return "\nXG0 X=${convertX()} Y=${convertY()} Z=$z T=${drill.id}";
  }
}
