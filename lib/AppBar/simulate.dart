import 'package:flutter/material.dart';

//Simulation Tab in AppBar
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
                //Run
              } else if (value == 1) {
                //Render final
              }
            }));
  }
}
