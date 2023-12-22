import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/AppBar/edit_overlay/create_path.dart';

import '../../provider_lib.dart';

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
            SizedBox(
              width: 300,
              child: ListView(
                children: [
                  for (var item in pathDirectory)
                    item,
                  const Create_Path_Button()
                ],
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
          ref.read(path_directory_provider.notifier).add(const Path_Object());
        },
        child: const Icon(add_box_outlined),
      ),
    );
  }
}

class Path_Mask extends ConsumerWidget {
  const Path_Mask({super.key});

  static const IconData arrow_drop_up_sharp =
      IconData(0xe799, fontFamily: 'MaterialIcons');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.white))),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          IconButton(
            icon: const Icon(arrow_drop_up_sharp),
            onPressed: () {
              ref.read(show_path_editor_provider.notifier).set(false);
            },
          )
        ],
      ),
    );
  }
}
