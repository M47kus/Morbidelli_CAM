import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/bar/drill/drill_class.dart';
import 'package:morbidelli_cam/editor/data_parse.dart';
import 'package:morbidelli_cam/provider/path_privider_lib.dart';
import 'package:morbidelli_cam/provider/provider_lib.dart';

import '../base/edit.dart';
import 'drill_data.dart';

class DrillCreator extends ConsumerStatefulWidget {
  final Drill? drill;
  final bool isNew;

  const DrillCreator({super.key, this.isNew = false, this.drill});

  @override
  ConsumerState<DrillCreator> createState() => _DrillCreatorState();
}

class _DrillCreatorState extends ConsumerState<DrillCreator> with Edit {
  TextEditingController drilltxt = TextEditingController();

  void _init() {
    if (widget.drill != null) {
      drilltxt.text = widget.drill!.name;
    } else {
      drilltxt.text = ref.read(drillclassprovider).values.toList()[0].name;
    }
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
        buildAppBar(ref, name: "Drill", onCanceled: onCancel, onSaved: () {
          int objId = ref.read(entityProvider.notifier).getNewObjId();
          //if object is already created update old object

          if (widget.isNew == false) {
            objId = ref.read(pathObjectIdProvider);
          }
          onConfirm(
              ref,
              objId,
              DrillData(
                drill: ref.read(drillclassprovider)[drilltxt.text],
                id: objId,
              ));
        }),
        Expanded(
            child: Column(children: [
          DropdownMenu<Drill>(
            initialSelection: ref.read(drillclassprovider)[drilltxt.text],
            controller: drilltxt,
            requestFocusOnTap: true,
            dropdownMenuEntries: ref
                .read(drillclassprovider)
                .values
                .map<DropdownMenuEntry<Drill>>((Drill drill) {
              return DropdownMenuEntry<Drill>(
                value: drill,
                label: drill.name,
              );
            }).toList(),
          ),
        ])),
      ],
    );
  }
}
