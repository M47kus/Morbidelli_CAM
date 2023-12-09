import 'package:flutter/material.dart';
import 'package:morbidelli_cam/editor.dart';
import 'package:morbidelli_cam/model.dart';
import 'package:ditredi/ditredi.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class AppBar_View extends StatefulWidget {
  const AppBar_View({super.key});

  @override
  State<AppBar_View> createState() => _AppBar_ViewState();
}

class _AppBar_ViewState extends State<AppBar_View> {
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
                print("0");
              } else if (value == 1) {
                print("1");
              } else if (value == 2) {
                print("2");
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
