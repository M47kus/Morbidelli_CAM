import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/editor.dart';
import 'package:ditredi/ditredi.dart';
import 'package:morbidelli_cam/provider_lib.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class AppBar_View extends ConsumerStatefulWidget {
  const AppBar_View({super.key});

  @override
  ConsumerState<AppBar_View> createState() => _AppBar_ViewState();
}

class _AppBar_ViewState extends ConsumerState<AppBar_View> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: PopupMenuButton(
            icon: const Text("View"),
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
                  child: Text("Side"),
                ),
                const PopupMenuItem<int>(
                  value: 3,
                  child: Text("Solid"),
                ),
                const PopupMenuItem<int>(
                  value: 4,
                  child: Text("Wireframe"),
                ),
                const PopupMenuItem<int>(
                  value: 5,
                  child: Text("Points"),
                ),
                const PopupMenuItem<int>(
                  value: 6,
                  child: Text("Re-Render"),
                ),
              ];
            },
            onSelected: (value) {
              if (value == 0) {
                ref.read(modelViewProvider.notifier).set("Top");
              } else if (value == 1) {
                ref.read(modelViewProvider.notifier).set("Front");
              } else if (value == 2) {
                ref.read(modelViewProvider.notifier).set("Side");
              } else if (value == 3) {
                print("3");
              } else if (value == 4) {
                print("4");
              } else if (value == 5) {
                print("5");
              } else if (value == 6) {
                print("6");
              }
            }));
  }
}
