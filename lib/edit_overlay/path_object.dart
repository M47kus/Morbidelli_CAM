import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../path_privider_lib.dart';

class PathSubObject extends ConsumerStatefulWidget {
  const PathSubObject({super.key});

  @override
  ConsumerState<PathSubObject> createState() => _PathSubObjectState();
}

class _PathSubObjectState extends ConsumerState<PathSubObject> {
  @override
  Widget build(BuildContext context) {
    Map subobjectList =
        ref.watch(pathEntityProvider)[ref.watch(pathDirectoryIdProvider)]!;
    return ListView(
      children: [for (var data in subobjectList.values) data.getInfoButton()],
    );
  }
}
