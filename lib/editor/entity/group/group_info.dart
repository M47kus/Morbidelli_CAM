import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/editor/entity/base/info.dart';
import 'package:morbidelli_cam/provider/path_privider_lib.dart';

//Detailed info Button on right side
class GroupInfo extends ConsumerStatefulWidget with Info {
  final int id;
  final Function selectFunction;
  List? entitys;
  GroupInfo(
      {super.key,
      required this.id,
      required this.selectFunction,
      this.entitys});

  @override
  ConsumerState<GroupInfo> createState() => _GroupInfoState();
}

class _GroupInfoState extends ConsumerState<GroupInfo> {
  bool selected = false;
  List entitys = [];

  void _init() {
    if (widget.entitys != null) {
      entitys = widget.entitys!;
    }
  }

  void initState() {
    super.initState();
    _init();
  }

  @override
  void didUpdateWidget(GroupInfo oldWidget) {
    super.didUpdateWidget(oldWidget);
    _init();
  }

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
        child: Column(
          children: [
            ListTile(
              onTap: () {
                if (ref.watch(pathObjectEditProvider)) {
                  longPress();
                } else {
                  shortPress();
                }
              },
              onLongPress: () {
                if (!ref.watch(pathObjectEditProvider)) {
                  longPress();
                } else {
                  shortPress();
                }
              },
              dense: true,
              selected: selected,
              selectedColor: Colors.lightGreen,
              tileColor: Colors.black12,
              visualDensity: const VisualDensity(vertical: -4),
              leading: const Text(
                "Group",
                style: TextStyle(fontSize: 12),
              ),
              trailing: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: widget.getEntityData(ref, widget.id),
              ),
            ),
            SizedBox(
                height: 200,
                child: ListView(
                  children: [
                    for (var item in entitys)
                      item.getInfoButton(item.id, (key, select) {
                        setState(() {
                          if (select) {
                            ref.read(pathSelectedProvider.notifier).add(key);
                          } else {
                            ref.read(pathSelectedProvider.notifier).remove(key);
                          }
                          if (ref.read(pathSelectedProvider).isEmpty) {
                            ref
                                .read(pathObjectEditProvider.notifier)
                                .set(false);
                          } else {
                            ref.read(pathObjectEditProvider.notifier).set(true);
                          }
                          print(ref.read(pathSelectedProvider));
                        });
                      })
                  ],
                )),
          ],
        ));
  }
}
