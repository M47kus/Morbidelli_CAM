import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/edit_overlay/path_directory.dart';
import 'package:morbidelli_cam/edit_overlay/path_object.dart';
import '../../provider_lib.dart';
import 'edit_mask.dart';

class Path_Editor extends ConsumerStatefulWidget {
  const Path_Editor({super.key});

  @override
  ConsumerState<Path_Editor> createState() => _Path_EditorState();
}

class _Path_EditorState extends ConsumerState<Path_Editor> {
  @override
  Widget build(BuildContext context) {
    List pathDirectory = ref.watch(path_directory_provider);
    return Column(
      children: [
        if (ref.watch(show_path_editor_provider) == true) const Path_Mask(),
        Expanded(
            child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: 300,
                  child: ListView(
                    children: [
                      for (var item in pathDirectory) item,
                      const Create_Path_Button()
                    ],
                  ),
                ),
              ),
            ),
            if (ref.watch(show_path_editor_provider) == true) const Expanded(
              child: Align(
                alignment: Alignment.topRight,
                child: SizedBox(
                  width: 300,
                  child: Path_SubObject()
                ),
              ),
            )
          ],
        ))
      ],
    );
  }
}

class Create_Path_Button extends ConsumerWidget {
  const Create_Path_Button({super.key});

  static const IconData add_box_outlined =
      IconData(0xee3c, fontFamily: 'MaterialIcons');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 15, right: 22, bottom: 8),
      child: OutlinedButton(
        onPressed: () {
          ref.read(show_path_editor_provider.notifier).set(true);
          int newId = ref.read(path_directory_provider).length;
          ref
              .read(path_directory_provider.notifier)
              .add(Path_Directory(id: newId));
          ref.read(path_edit_id_provider.notifier).set(newId);
        },
        child: const Icon(add_box_outlined),
      ),
    );
  }
}
