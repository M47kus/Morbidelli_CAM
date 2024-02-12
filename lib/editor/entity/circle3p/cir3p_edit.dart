import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/editor/data_parse.dart';
import 'package:morbidelli_cam/editor/widgets/origin_point.dart';
import 'package:morbidelli_cam/helper/check_button.dart';
import 'package:morbidelli_cam/helper/textinput.dart';
import 'package:morbidelli_cam/provider/path_privider_lib.dart';
import '../base/edit.dart';
import 'cir3p_data.dart';

enum Cir3PAxisRotation { left, right, dynamic }

class Cir3PCreator extends ConsumerStatefulWidget {
  final double? x;
  final double? y;
  final double? z;
  final double? xp;
  final double? yp;
  final double? zp;
  final int? fix;
  final int? fixp;
  final bool isNew;
  final Cir3PAxisRotation? rotation;

  const Cir3PCreator(
      {super.key,
      this.isNew = false,
      this.x,
      this.y,
      this.z,
      this.fix,
      this.xp,
      this.yp,
      this.zp,
      this.rotation,
      this.fixp});

  @override
  ConsumerState<Cir3PCreator> createState() => _Cir3PCreatorState();
}

class _Cir3PCreatorState extends ConsumerState<Cir3PCreator> with Edit {
  final TextEditingController xptxt = TextEditingController();
  final TextEditingController yptxt = TextEditingController();
  final TextEditingController zptxt = TextEditingController();

  int fixpointp = 1;
  Cir3PAxisRotation rotation = Cir3PAxisRotation.right;
  bool leftdrill = false;

  void _init() {
    xtxt.clear();
    ytxt.clear();
    ztxt.clear();
    xptxt.clear();
    yptxt.clear();
    zptxt.clear();

    if (widget.x != null) {
      xtxt.text = widget.x.toString();
    }
    if (widget.y != null) {
      ytxt.text = widget.y.toString();
    }
    if (widget.z != null) {
      ztxt.text = widget.z.toString();
    }
    if (widget.xp != null) {
      xptxt.text = widget.xp.toString();
    }
    if (widget.yp != null) {
      yptxt.text = widget.yp.toString();
    }
    if (widget.zp != null) {
      zptxt.text = widget.zp.toString();
    }

    rotation = widget.rotation ?? Cir3PAxisRotation.right;
    leftdrill = rotation == Cir3PAxisRotation.left ? true : false;
    fixpoint = widget.fix ?? 1;
    fixpointp = widget.fixp ?? 1;
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void didUpdateWidget(Cir3PCreator oldWidget) {
    super.didUpdateWidget(oldWidget);
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildAppBar(ref, name: "Circle 3 Points", onCanceled: onCancel,
            onSaved: () {
          int dirId = ref.read(pathDirectoryIdProvider);
          int objId = ref.read(entityProvider.notifier).getNewObjId(dirId);
          //if object is already created update old object

          if (widget.isNew == false) {
            objId = ref.read(pathObjectIdProvider);
          }
          onConfirm(
              ref,
              objId,
              Cir3PData(
                x: xtxt.text == "" ? 0 : double.parse(xtxt.text),
                y: xtxt.text == "" ? 0 : double.parse(ytxt.text),
                z: xtxt.text == "" ? 0 : double.parse(ztxt.text),
                xp: xptxt.text == "" ? 0 : double.parse(xptxt.text),
                yp: xptxt.text == "" ? 0 : double.parse(yptxt.text),
                zp: xptxt.text == "" ? 0 : double.parse(zptxt.text),
                fix: fixpoint,
                fixp: fixpointp,
                rotation: rotation,
                id: objId,
              ));
        }),
        Expanded(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FixPointChose(fixpoint, (state) {
                    fixpoint = state;
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FixPointChose(fixpointp, (state) {
                    fixpointp = state;
                  }),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: ConfigTextInput(label: "X", controller: xtxt),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: ConfigTextInput(label: "Y", controller: ytxt),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: ConfigTextInput(label: "Z", controller: ztxt),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  child: const VerticalDivider(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: ConfigTextInput(label: "XP", controller: xptxt),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: ConfigTextInput(label: "YP", controller: yptxt),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: ConfigTextInput(label: "ZP", controller: zptxt),
                      ),
                    ],
                  ),
                )
              ],
            ),
            ConfigBooleanButton(
                isActive: leftdrill,
                onTap: () {
                  setState(() {
                    if (leftdrill == false) {
                      rotation = Cir3PAxisRotation.left;
                    } else {
                      rotation = Cir3PAxisRotation.right;
                    }
                    leftdrill =
                        rotation == Cir3PAxisRotation.left ? true : false;
                  });
                },
                txt: "Left Drill")
          ],
        )),
      ],
    );
  }
}
