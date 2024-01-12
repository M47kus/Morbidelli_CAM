import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/edit_overlay/g0/go_info.dart';
import 'package:morbidelli_cam/helper/textinput.dart';
import 'package:morbidelli_cam/provider_lib.dart';

import '../../load_settings.dart';
import '../helper/origin_point.dart';

class G0_Creator extends ConsumerStatefulWidget {
  final double? x;
  final double? y;
  final double? z;
  final int? fix;
  G0_Creator([this.x, this.y, this.z, this.fix]);

  final TextEditingController x_txt = TextEditingController();
  final TextEditingController y_txt = TextEditingController();
  final TextEditingController z_txt = TextEditingController();

  @override
  ConsumerState<G0_Creator> createState() => _G0_CreatorState();
}

class _G0_CreatorState extends ConsumerState<G0_Creator> {
  static const IconData cancel_outlined =
      IconData(0xef28, fontFamily: 'MaterialIcons');
  static const IconData check_circle_outline =
      IconData(0xef47, fontFamily: 'MaterialIcons');

  int fix_point = 1;


  @override
  void initState() {
    super.initState();

    print("init edit");
    if (widget.x != null) {
      widget.x_txt.text = widget.x.toString();
    }
    if (widget.y != null) {
      widget.y_txt.text = widget.y.toString();
    }
    if (widget.z != null) {
      widget.z_txt.text = widget.z.toString();
    }

    fix_point = widget.fix ?? 1;
  }

  @override
  void didUpdateWidget(G0_Creator oldWidget) {
    super.didUpdateWidget(oldWidget);

    print("init edit");
    if (widget.x != null) {
      widget.x_txt.text = widget.x.toString();
    }
    if (widget.y != null) {
      widget.y_txt.text = widget.y.toString();
    }
    if (widget.z != null) {
      widget.z_txt.text = widget.z.toString();
    }

    fix_point = widget.fix ?? 1;
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
                      //blend in edit window
                      int dirId = ref.read(path_directory_id_provider);
                      ref.watch(show_creator_provider.notifier).set(false);
                      ref.read(path_entity_provider.notifier).remove_object(dirId, 0);
                      ref.read(path_directory_lock_provider.notifier);
                      ref
                          .read(path_directory_lock_provider.notifier)
                          .set(false);
                      if (hide_model_creation_window) {
                        ref.read(show_model_provider.notifier).set(true);
                      }
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

                        ref.read(path_entity_provider.notifier).new_object(
                            dirId,
                            objId,
                            G0_Data(
                                id: objId,
                                x: double.parse(widget.x_txt.text),
                                y: double.parse(widget.y_txt.text),
                                z: double.parse(widget.z_txt.text),
                                fix: fix_point));

                        //blend in edit window
                        ref.watch(show_creator_provider.notifier).set(false);
                        ref.read(path_entity_provider.notifier).remove_object(dirId, 0);
                        ref
                            .read(path_directory_lock_provider.notifier)
                            .set(false);
                        if (hide_model_creation_window) {
                          ref.read(show_model_provider.notifier).set(true);
                        }
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
          ConfigTextInput(label: "X", controller: widget.x_txt),
          ConfigTextInput(label: "Y", controller: widget.y_txt),
          ConfigTextInput(label: "Z", controller: widget.z_txt)
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
  G0_Data(
      {required this.id, this.x, this.y, this.z, this.fix});

  Widget getInfoButton() {
    return G0_Info(id: this.id);
  }
}
