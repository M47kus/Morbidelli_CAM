import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/editor/model/editor.dart';
import 'package:morbidelli_cam/provider/path_privider_lib.dart';

import '../data_parse.dart';
import '../entity_creator_build.dart';

class MainWindow extends ConsumerWidget {
  const MainWindow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Visibility(
        visible: !ref.watch(showCreatorProvider),
      replacement: buildEditWindow(ref.watch(entityProvider)[
      ref.watch(pathObjectIdProvider)]),
        child: const Editor(),
    );
  }
}
