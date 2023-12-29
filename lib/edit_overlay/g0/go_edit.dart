import 'package:flutter/material.dart';

import '../helper/origin_point.dart';

class G0_Creator extends StatefulWidget {
  const G0_Creator({super.key});

  @override
  State<G0_Creator> createState() => _G0_CreatorState();
}

class _G0_CreatorState extends State<G0_Creator> {
  static const IconData cancel_outlined =
      IconData(0xef28, fontFamily: 'MaterialIcons');
  static const IconData check_circle_outline =
      IconData(0xef47, fontFamily: 'MaterialIcons');
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: AppBar(
            title: Text("G0"),
            actions: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child:
                    IconButton(onPressed: () {}, icon: Icon(cancel_outlined)),
              ),
              Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: IconButton(
                      onPressed: () {}, icon: Icon(check_circle_outline)))
            ],
          ),
        ),
        Expanded(
            child: Container(
          child: Fix_Point_Chose(),
        ))
      ],
    );
  }
}
