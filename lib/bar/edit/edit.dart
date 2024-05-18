import 'package:flutter/material.dart';
import 'package:morbidelli_cam/bar/edit/base_model/base.dart';

//Edit Tab in AppBar
class AppBarEdit extends StatelessWidget {
  const AppBarEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: PopupMenuButton(
        iconSize: 15,
          icon: const Text("Edit", style: TextStyle(fontSize: 12),),
          itemBuilder: (context) {
            return [
              const PopupMenuItem<int>(
                value: 0,
                child: Text("Edit Base"),
              ),
            ];
          },
          onSelected: (value) {
              if (value == 0) {
              //Edit Base
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const EditBase()));
            }
          }),
    );
  }
}
