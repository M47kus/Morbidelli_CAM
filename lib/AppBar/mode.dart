import 'package:flutter/material.dart';

class AppBar_Mode extends StatelessWidget {
  const AppBar_Mode({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: PopupMenuButton(
            icon: const Text("Mode"),
            itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text("path from Object (Auto)"),
                ),
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text("Object from Path (Manual)"),
                ),
              ];
            },
            onSelected: (value) {
              if (value == 0) {
                print("0");
              } else if (value == 1) {
                print("1");
              }
            }));
  }
}
