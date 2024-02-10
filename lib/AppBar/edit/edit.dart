import 'package:flutter/material.dart';
import 'package:morbidelli_cam/AppBar/edit/base.dart';

//Edit Tab in AppBar
class AppBarEdit extends StatelessWidget {
  const AppBarEdit({super.key});

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
