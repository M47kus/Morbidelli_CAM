import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/provider/provider_lib.dart';

import '../../AppBar/drill/drill_class.dart';
import '../../editor_functions/data_parse.dart';
import '../../provider/path_privider_lib.dart';
import '../base/edit.dart';
import '../helper/data.dart';
import 'drill_info.dart';

class DrillCreator extends ConsumerStatefulWidget {
  final Drill? drill;
  final bool isNew;

  const DrillCreator({super.key, this.isNew = false, this.drill});

  @override
  ConsumerState<DrillCreator> createState() => _DrillCreatorState();
}

class _DrillCreatorState extends ConsumerState<DrillCreator> with Edit {
  void _init() {
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void didUpdateWidget(DrillCreator oldWidget) {
    super.didUpdateWidget(oldWidget);
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildAppBar(ref, name: "G0", onCanceled: onCancel, onSaved: () {
          int dirId = ref.read(pathDirectoryIdProvider);
          int objId = ref.read(entityProvider.notifier).getNewObjId(dirId);
          //if object is already created update old object

          if (widget.isNew == false) {
            objId = ref.read(pathObjectIdProvider);
          }
          onConfirm(
              ref,
              objId,
              DrillData(
                drill: null,//todo: change to drill, drill provider to map
                id: objId,
              ));
        }),
        Expanded(
            child: Column(children: [
          DropdownButtonFormField(
              elevation: 1,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (String? data) {},
              items: ref
                  .read(drillclassprovider)
                  .map<DropdownMenuItem<String>>((var value) {
                return DropdownMenuItem<String>(
                  child: Text(value.name),
                  value: widget.drill != null ? widget.drill!.name : "",
                );
              }).toList())
        ]))
      ],
    );
  }
}

class DrillData extends Data {
  int id;
  Drill? drill;

  DrillData({
    this.drill,
    required this.id,
  });

  Widget getInfoButton() {
    return DrillInfo(id: id);
  }
}
