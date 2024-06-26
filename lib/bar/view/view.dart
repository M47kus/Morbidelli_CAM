import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/provider/provider_lib.dart';

//View Tab in AppBar
class FootBarView extends ConsumerStatefulWidget {
  const FootBarView({super.key});

  @override
  ConsumerState<FootBarView> createState() => _FootBarViewState();
}

class _FootBarViewState extends ConsumerState<FootBarView> {
  //set view angles and appearance modes
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: PopupMenuButton(
            iconSize: 15,
            icon: const Text(
              "View",
              style: TextStyle(fontSize: 11),
            ),
            itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text("Top"),
                ),
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text("Front"),
                ),
                const PopupMenuItem<int>(
                  value: 2,
                  child: Text("Left"),
                ),
                const PopupMenuItem<int>(
                  value: 3,
                  child: Text("Right"),
                ),
                const PopupMenuItem<int>(
                  value: 4,
                  child: Text("Free"),
                ),
              ];
            },
            onSelected: (value) {
              if (value == 0) {
                ref.read(modelViewProvider.notifier).setTop();
              } else if (value == 1) {
                ref.read(modelViewProvider.notifier).setFront();
              } else if (value == 2) {
                ref.read(modelViewProvider.notifier).setSideLeft();
              } else if (value == 3) {
                ref.read(modelViewProvider.notifier).setSideRight();
              } else if (value == 4) {
                ref.read(modelViewProvider.notifier).setFree();
              }
            }));
  }
}
