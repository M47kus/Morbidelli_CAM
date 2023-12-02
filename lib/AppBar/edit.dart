import 'package:flutter/material.dart';

class AppBar_Edit extends StatelessWidget {
  const AppBar_Edit({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: PopupMenuButton(
          icon: const Text("Edit"),
          itemBuilder: (context) {
            return [
              const PopupMenuItem<int>(
                value: 0,
                child: Text("Create Path"),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text("Change Path"),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text("Edit Base"),
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
            }
          }),
    );
  }
}
