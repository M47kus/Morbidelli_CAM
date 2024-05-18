import 'package:flutter/material.dart';
import 'package:morbidelli_cam/bar/view/apearance.dart';
import 'package:morbidelli_cam/bar/view/view.dart';


class CustomFootBar extends StatelessWidget {

  const CustomFootBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.topLeft,

      child: Row(
        children: <Widget>[
          AppBarView(),
          FootBarView()
        ],

      ),
    );
  }
}
