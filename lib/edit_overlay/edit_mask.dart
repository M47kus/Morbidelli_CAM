import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/edit_overlay/circle3p/cir3p_mask.dart';
import 'package:morbidelli_cam/edit_overlay/g0/go_mask.dart';
import 'package:morbidelli_cam/edit_overlay/g1/g1_mask.dart';
import '../editor_functions/data_parse.dart';
import '../provider/path_privider_lib.dart';
import 'drill/drill_mask.dart';

//Mask for adding new commands to cnc list
class PathMask extends ConsumerWidget {
  const PathMask({super.key});

  static const IconData arrowDropUpSharp =
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
          //close Button
          IconButton(
            icon: const Icon(arrowDropUpSharp),
            onPressed: () {
              //close entity editor
              int dirId = ref.read(pathDirectoryIdProvider);
              ref.watch(showCreatorProvider.notifier).set(false);
              ref.read(entityProvider.notifier).removeObject(dirId, 0);
              ref.read(pathDirectoryLockProvider.notifier).set(false);

              //close edit overlay
              ref.read(showPathEditorProvider.notifier).set(false);
              ref.read(pathDirectoryIdProvider.notifier).set(0);
              ref.read(pathDirectoryLockProvider.notifier).set(false);
              ref.read(showModelProvider.notifier).set(true);
            },
          ),
          //G0 Button
          const DrillMask(),
          const G0Mask(),
          const G1Mask(),
          const Cir3PMask()
        ],
      ),
    );
  }
}
