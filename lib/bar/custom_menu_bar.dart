import 'package:flutter/material.dart';
import 'package:morbidelli_cam/bar/drill/drill.dart';
import 'package:morbidelli_cam/bar/edit/edit.dart';
import 'package:morbidelli_cam/bar/files/files.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Row(
        children: <Widget>[
          SizedBox(
            height: 30,
            width: 30,
            child: IconButton(
              iconSize: 15,
              color: Colors.black,
              icon: const Icon(Icons.chevron_left),
              onPressed: () {},
            ),
          ),
          const AppBarFiles(),
          const AppBarEdit(),
          const AppBarDrill()
        ],
      ),
    );
  }
}
