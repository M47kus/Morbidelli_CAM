import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/edit_overlay/g0/go_mask.dart';
import 'package:morbidelli_cam/edit_overlay/g1/g1_mask.dart';
import '../load_settings.dart';
import '../path_privider_lib.dart';

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
              ref.read(pathEntityProvider.notifier).removeObject(dirId, 0);
              ref.read(pathDirectoryLockProvider.notifier).set(false);
              if (hideModelInCreation) {
                ref.read(showModelProvider.notifier).set(true);
              }

              //close edit overlay
              ref.read(showPathEditorProvider.notifier).set(false);
              ref.read(pathDirectoryIdProvider.notifier).set(0);
              ref.read(pathDirectoryLockProvider.notifier).set(false);
              ref.read(showModelProvider.notifier).set(true);
            },
          ),
          //G0 Button
          const G0Mask(),
          const G1Mask()
        ],
      ),
    );
  }
}
