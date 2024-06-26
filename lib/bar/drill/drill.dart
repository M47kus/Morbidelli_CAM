import 'package:flutter/material.dart';
import 'package:morbidelli_cam/bar/drill/config/drill_config.dart';

//Drill Tab in App Bar
class AppBarDrill extends StatelessWidget {
  const AppBarDrill({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: PopupMenuButton(
          iconSize: 15,
            icon: const Text("Drill", style: TextStyle(fontSize: 12),),
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DrillConfig()));
              } else if (value == 1) {
                //used Drills
              }
            }));
  }
}
