import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/edit_overlay/g0/go_mask.dart';
import '../provider_lib.dart';

class Path_Mask extends ConsumerWidget {
  const Path_Mask({super.key});

  static const IconData arrow_drop_up_sharp =
  IconData(0xe799, fontFamily: 'MaterialIcons');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.white))),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          IconButton(
            icon: const Icon(arrow_drop_up_sharp),
            onPressed: () {
              ref.read(show_path_editor_provider.notifier).set(false);
              ref.read(path_edit_id_provider.notifier).set(-1);
            },
          ),
          G0_Mask()
        ],
      ),
    );
  }
}
