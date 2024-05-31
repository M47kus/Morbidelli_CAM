import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/editor/data_parse.dart';
import 'package:morbidelli_cam/editor/entity/base/edit.dart';
import 'package:morbidelli_cam/editor/widgets/offset_corection.dart';
import 'package:morbidelli_cam/editor/widgets/origin_point.dart';
import 'package:morbidelli_cam/helper/textinput.dart';
import 'package:morbidelli_cam/provider/path_privider_lib.dart';

import 'init_data.dart';

class InitCreator extends ConsumerStatefulWidget {
  final String? x;
  final String? y;
  final String? z;
  final String? bx;
  final String? by;
  final String? bz;
  final bool isNew;
  const InitCreator(
      {this.x,
      this.y,
      this.z,
      this.bx,
      this.by,
      this.bz,
      super.key,
      this.isNew = false});

  @override
  ConsumerState<InitCreator> createState() => _InitCreatorState();
}

class _InitCreatorState extends ConsumerState<InitCreator> with Edit {
  final TextEditingController bxtxt = TextEditingController();
  final TextEditingController bytxt = TextEditingController();
  final TextEditingController bztxt = TextEditingController();

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
    if (widget.bx != null) {
      bxtxt.text = widget.bx.toString();
    }
    if (widget.by != null) {
      bytxt.text = widget.by.toString();
    }
    if (widget.bz != null) {
      bztxt.text = widget.bz.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void didUpdateWidget(InitCreator oldWidget) {
    super.didUpdateWidget(oldWidget);
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildAppBar(ref, name: "Preferences", onCanceled: onCancel, onSaved: () {
          int objId = ref.read(entityProvider.notifier).getNewObjId();
          //if object is already created update old object

          if (widget.isNew == false) {
            objId = ref.read(pathObjectIdProvider);
          }
          onConfirm(
              ref,
              objId,
              widget.isNew,
              InitData(
                id: objId,
                x: xtxt.text == "" ? "0" : xtxt.text,
                y: ytxt.text == "" ? "0" : ytxt.text,
                z: ztxt.text == "" ? "0" : ztxt.text,
                bx: bxtxt.text == "" ? "0" : bxtxt.text,
                by: bytxt.text == "" ? "0" : bytxt.text,
                bz: bztxt.text == "" ? "0" : bztxt.text,
              ));
        }),
        Expanded(
            child: Column(children: [
          ConfigTextInput(label: "DX", controller: xtxt),
          ConfigTextInput(label: "DY", controller: ytxt),
          ConfigTextInput(label: "DZ", controller: ztxt),
          Divider(),
          ConfigTextInput(label: "BX", controller: bxtxt),
          ConfigTextInput(label: "BY", controller: bytxt),
          ConfigTextInput(label: "BZ", controller: bztxt)
        ]))
      ],
    );
  }
}
