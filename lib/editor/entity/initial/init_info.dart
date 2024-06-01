import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/editor/entity/base/info.dart';
import 'package:morbidelli_cam/provider/path_privider_lib.dart';

//Detailed info Button on right side
class InitInfo extends ConsumerStatefulWidget with Info {
  final int id;
  final Function selectFunction;
  InitInfo({super.key, required this.id, required this.selectFunction});

  @override
  ConsumerState<InitInfo> createState() => _InitInfoState();
}

class _InitInfoState extends ConsumerState<InitInfo> {
  bool selected = false;

  void longPress() {
    if (selected) {
      setState(() {
        selected = false;
        widget.selectFunction(widget.id, false);
      });
    } else {
      setState(() {
        selected = true;
        widget.selectFunction(widget.id, true);
      });
    }
  }

  void shortPress() {
    widget.onTab(ref, widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
        child: ListTile(
          selected: selected,
          selectedColor: Colors.lightGreen,
          onTap: () {
            if (ref.watch(pathObjectEdit)) {
              longPress();
            } else {
              shortPress();
            }
          },
          onLongPress: () {
            if (!ref.watch(pathObjectEdit)) {
              longPress();
            } else {
              shortPress();
            }
          },
          dense: true,
          tileColor: Colors.black12,
          visualDensity: const VisualDensity(vertical: -4),
          leading: const Text(
            "Init",
            style: TextStyle(fontSize: 12),
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: widget.getEntityData(ref, widget.id),
          ),
        ));
  }
}
