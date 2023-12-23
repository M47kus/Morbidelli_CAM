import 'package:flutter/material.dart';
import 'package:morbidelli_cam/AppBar/drill/drill_config.dart';

//Drill Tab in App Bar
class AppBar_drill extends StatelessWidget {
  const AppBar_drill({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: PopupMenuButton(
            icon: const Text("Drill"),
            itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text("open Config"),
                ),
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text("used Drills"),
                ),
              ];
            },
            onSelected: (value) {
              if (value == 0) {
                //open Config
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Drill_Config()));
              } else if (value == 1) {
                //used Drills
              }
            }));
  }
}