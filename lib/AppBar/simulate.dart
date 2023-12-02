import 'package:flutter/material.dart';

class AppBar_simulate extends StatelessWidget {
  const AppBar_simulate({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: PopupMenuButton(
            icon: const Text("Simulate"),
            itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text("Run"),
                ),
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text("Render final"),
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
