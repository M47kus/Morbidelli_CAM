import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/edit_overlay/g0/go_edit.dart';
import 'package:morbidelli_cam/load_settings.dart';

import '../../provider_lib.dart';

//Detailed info Button on right side
class G0_Info extends ConsumerWidget {
  final int id;
  G0_Info({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
      child: OutlinedButton(
          onPressed: () {
            //show creation window
            G0_Data obj_data = ref.read(
                path_entity_provider)[ref.read(path_edit_id_provider)]![id];
            //todo: load widget data
            //disable directory buttons
            ref.read(path_directory_lock_provider.notifier).set(true);
            if (hide_model_creation_window)
              ref.read(show_model_provider.notifier).set(false);
          },
          child: const Text("G0")),
    );
  }
}
