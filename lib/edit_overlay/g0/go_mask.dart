import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/edit_overlay/g0/go_edit.dart';

import '../../load_settings.dart';
import '../../path_privider_lib.dart';

//icon Button in Edit Mask (top)
class G0_Mask extends ConsumerWidget {
  const G0_Mask({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox.fromSize(
        size: const Size(65, 65),
        child: ClipOval(
          child: Material(
            child: InkWell(
              onTap: () {
                //create new empty entity in data structure
                int dirId = ref.read(path_directory_id_provider);
                ref
                    .read(path_entity_provider.notifier)
                    .new_object(dirId, 0, G0_Data(id: 0));
                ref.read(path_object_id_provider.notifier).set(0);
                ref.watch(show_creator_provider.notifier).set(true);
                //disable directory buttons
                ref.read(path_directory_lock_provider.notifier).set(true);
                if (hide_model_creation_window)
                  ref.read(show_model_provider.notifier).set(false);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/icons/B.bmp",
                  ),
                  const Text("G0"), // <-- Text
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
