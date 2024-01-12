import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/edit_overlay/g0/go_info.dart';
import 'package:morbidelli_cam/helper/textinput.dart';

import '../../path_privider_lib.dart';
import '../base/edit.dart';
import '../helper/origin_point.dart';

class G0_Creator extends ConsumerStatefulWidget {
  final double? x;
  final double? y;
  final double? z;
  final int? fix;
  G0_Creator([this.x, this.y, this.z, this.fix]);

  @override
  ConsumerState<G0_Creator> createState() => _G0_CreatorState();
}

class _G0_CreatorState extends ConsumerState<G0_Creator> with Edit {
  static const IconData cancel_outlined =
      IconData(0xef28, fontFamily: 'MaterialIcons');
  static const IconData check_circle_outline =
      IconData(0xef47, fontFamily: 'MaterialIcons');

  void _init() {
    if (widget.x != null) {
      x_txt.text = widget.x.toString();
    }
    if (widget.y != null) {
      y_txt.text = widget.y.toString();
    }
    if (widget.z != null) {
      z_txt.text = widget.z.toString();
    }

    fix_point = widget.fix ?? 1;
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void didUpdateWidget(G0_Creator oldWidget) {
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
                      OnCancel(ref);
                    },
                    icon: const Icon(cancel_outlined)),
              ),
              Padding(
                  //confirm
                  padding: const EdgeInsets.all(4.0),
                  child: IconButton(
                      onPressed: () {
                        int dirId = ref.read(path_directory_id_provider);
                        int objId = ref
                            .read(path_entity_provider.notifier)
                            .get_new_obj_id(dirId);

                        OnConfirm(
                            ref,
                            G0_Data(
                                id: objId,
                                x: double.parse(x_txt.text),
                                y: double.parse(y_txt.text),
                                z: double.parse(z_txt.text),
                                fix: fix_point));
                      },
                      icon: const Icon(check_circle_outline)))
            ],
          ),
        ),
        Expanded(
            child: Column(children: [
          Fix_Point_Chose(fix_point, (state) {
            fix_point = state;
          }),
          ConfigTextInput(label: "X", controller: x_txt),
          ConfigTextInput(label: "Y", controller: y_txt),
          ConfigTextInput(label: "Z", controller: z_txt)
        ]))
      ],
    );
  }
}

class G0_Data {
  int id;
  double? x;
  double? y;
  double? z;
  int? fix;
  G0_Data({required this.id, this.x, this.y, this.z, this.fix});

  Widget getInfoButton() {
    return G0_Info(id: this.id);
  }
}
