import 'package:flutter/material.dart';
import 'package:morbidelli_cam/Files/import.dart';

class AppBar_Files extends StatefulWidget {
  AppBar_Files({super.key});

  @override
  State<AppBar_Files> createState() => _AppBar_FilesState();
}

class _AppBar_FilesState extends State<AppBar_Files> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: PopupMenuButton(
            icon: const Text("Files"),
            itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text("Import"),
                ),
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text("Save"),
                ),
                const PopupMenuItem<int>(
                  value: 2,
                  child: Text("Open"),
                ),
                const PopupMenuItem<int>(
                  value: 3,
                  child: Text("Settings"),
                ),
                const PopupMenuItem<int>(
                  value: 4,
                  child: Text("Export"),
                ),
              ];
            },
            onSelected: (value) {
              if (value == 0) {
                print("Import");
              } else if (value == 1) {
                print("1");
              } else if (value == 2) {
                print("2");
              } else if (value == 3) {
                print("3");
              } else if (value == 4) {
                print("4");
              }
            }));
  }
}
