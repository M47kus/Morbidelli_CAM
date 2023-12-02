import 'package:flutter/material.dart';

class AppBar_Files extends StatelessWidget {
  const AppBar_Files({super.key});

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
                print("0");
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
