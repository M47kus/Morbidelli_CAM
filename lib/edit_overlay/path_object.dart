import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/edit_overlay/g0/go_edit.dart';
import 'package:morbidelli_cam/edit_overlay/g0/go_info.dart';
import 'package:morbidelli_cam/provider_lib.dart';

class Path_SubObject extends ConsumerStatefulWidget {
  const Path_SubObject({super.key});

  @override
  ConsumerState<Path_SubObject> createState() => _Path_SubObjectState();
}

class _Path_SubObjectState extends ConsumerState<Path_SubObject> {
  @override
  Widget build(BuildContext context) {
    Map subobject_list = ref.watch(path_entity_provider)[ref.watch(path_edit_id_provider)]!;
    return ListView(
      children: [for(G0_Data data in subobject_list.values) data.info_button],
    );
  }
}
