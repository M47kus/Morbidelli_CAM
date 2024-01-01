import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/edit_overlay/g0/go_info.dart';
import 'package:morbidelli_cam/helper/textinput.dart';
import 'package:morbidelli_cam/provider_lib.dart';

import '../../load_settings.dart';
import '../helper/origin_point.dart';

class G0_Creator extends ConsumerWidget {
  final double? x;
  final double? y;
  final double? z;
  final int? fix;
  G0_Creator([this.x, this.y, this.z, this.fix]);

  static const IconData cancel_outlined =
      IconData(0xef28, fontFamily: 'MaterialIcons');
  static const IconData check_circle_outline =
      IconData(0xef47, fontFamily: 'MaterialIcons');

  final TextEditingController x_txt = TextEditingController();
  final TextEditingController y_txt = TextEditingController();
  final TextEditingController z_txt = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (x != null) {
      x_txt.text = x.toString();
    }
    if (y != null) {
      y_txt.text = y.toString();
    }
    if (z != null) {
      z_txt.text = z.toString();
    }

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
                      ref.read(path_creator_provider.notifier).set(null);
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
                        int dirId = ref.read(path_edit_id_provider);
                        int objId = ref
                            .read(path_entity_provider.notifier)
                            .get_new_obj_id(dirId);

                        ref.read(path_entity_provider.notifier).new_object(
                            dirId,
                            objId,
                            G0_Data(
                                id: objId,
                                x: double.parse(x_txt.text),
                                y: double.parse(y_txt.text),
                                z: double.parse(z_txt.text),
                                fix: ref.read(fix_point_provider)));

                        //blend in edit window
                        ref.read(path_creator_provider.notifier).set(null);
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
          Fix_Point_Chose(fix),
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
  double x;
  double y;
  double z;
  int fix;
  G0_Data(
      {required this.x,
      required this.y,
      required this.z,
      required this.fix,
      required this.id});

  Widget getInfoButton() {
    return G0_Info(id: this.id);
  }
}
