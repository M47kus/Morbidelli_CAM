import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/edit_overlay/g0/go_info.dart';
import 'package:morbidelli_cam/helper/textinput.dart';

import '../../path_privider_lib.dart';
import '../base/edit.dart';
import '../helper/origin_point.dart';

class G0Creator extends ConsumerStatefulWidget {
  final double? x;
  final double? y;
  final double? z;
  final int? fix;
  const G0Creator({this.x, this.y, this.z, this.fix, super.key});

  @override
  ConsumerState<G0Creator> createState() => _G0CreatorState();
}

class _G0CreatorState extends ConsumerState<G0Creator> with Edit {
  static const IconData cancelOutlined =
      IconData(0xef28, fontFamily: 'MaterialIcons');
  static const IconData checkCircleOutline =
      IconData(0xef47, fontFamily: 'MaterialIcons');

  void _init() {
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
  void didUpdateWidget(G0Creator oldWidget) {
    super.didUpdateWidget(oldWidget);
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: AppBar(
            title: const Text("G0"),
            actions: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: IconButton(
                    onPressed: () {
                      onCancel(ref);
                    },
                    icon: const Icon(cancelOutlined)),
              ),
              Padding(
                  //confirm
                  padding: const EdgeInsets.all(4.0),
                  child: IconButton(
                      onPressed: () {
                        int dirId = ref.read(pathDirectoryIdProvider);
                        int objId = ref
                            .read(pathEntityProvider.notifier)
                            .getNewObjId(dirId);

                        onConfirm(
                            ref,
                            G0Data(
                                id: objId,
                                x: double.parse(xtxt.text),
                                y: double.parse(ytxt.text),
                                z: double.parse(ztxt.text),
                                fix: fixpoint));
                      },
                      icon: const Icon(checkCircleOutline)))
            ],
          ),
        ),
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

class G0Data {
  int id;
  double? x;
  double? y;
  double? z;
  int? fix;
  G0Data({required this.id, this.x, this.y, this.z, this.fix});

  Widget getInfoButton() {
    return G0Info(id: id);
  }
}
