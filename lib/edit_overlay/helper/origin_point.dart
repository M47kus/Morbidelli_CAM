import 'package:flutter/material.dart';

class Fix_Point_Chose extends StatefulWidget {
  final int? intial_active;
  const Fix_Point_Chose([this.intial_active]);

  static const IconData border_style =
      IconData(0xe100, fontFamily: 'MaterialIcons');
  static const IconData border_top =
      IconData(0xe101, fontFamily: 'MaterialIcons');
  static const IconData border_right =
      IconData(0xe0ff, fontFamily: 'MaterialIcons');
  static const IconData border_left =
      IconData(0xe0fd, fontFamily: 'MaterialIcons');
  static const IconData border_bottom =
      IconData(0xe0f8, fontFamily: 'MaterialIcons');
  static const IconData border_clear =
      IconData(0xe0f9, fontFamily: 'MaterialIcons');

  @override
  State<Fix_Point_Chose> createState() => _Fix_Point_ChoseState();
}

class _Fix_Point_ChoseState extends State<Fix_Point_Chose> {
  final Color active_color = Colors.red;
  int active = 1;
  final Color default_color = Colors.white;

  @override
  Widget build(BuildContext context) {
    if(widget.intial_active != null) {active = widget.intial_active!;}
    return Column(
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    active = 1;
                  });
                },
                icon: Icon(
                  Fix_Point_Chose.border_style,
                  color: active == 1 ? active_color : default_color,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    active = 2;
                  });
                },
                icon: Icon(
                  Fix_Point_Chose.border_top,
                  color: active == 2 ? active_color : default_color,
                )),
            Transform.rotate(
                angle: 90 * 3.1415 / 180,
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        active = 3;
                      });
                    },
                    icon: Icon(
                      Fix_Point_Chose.border_style,
                      color: active == 3 ? active_color : default_color,
                    )))
          ],
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    active = 4;
                  });
                },
                icon: Icon(
                  Fix_Point_Chose.border_left,
                  color: active == 4 ? active_color : default_color,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    active = 5;
                  });
                },
                icon: Icon(
                  Fix_Point_Chose.border_clear,
                  color: active == 5 ? active_color : default_color,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    active = 6;
                  });
                },
                icon: Icon(
                  Fix_Point_Chose.border_right,
                  color: active == 6 ? active_color : default_color,
                ))
          ],
        ),
        Row(
          children: [
            Transform.rotate(
                angle: 270 * 3.1415 / 180,
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        active = 7;
                      });
                    },
                    icon: Icon(
                      Fix_Point_Chose.border_style,
                      color: active == 7 ? active_color : default_color,
                    ))),
            IconButton(
                onPressed: () {
                  setState(() {
                    active = 8;
                  });
                },
                icon: Icon(
                  Fix_Point_Chose.border_bottom,
                  color: active == 8 ? active_color : default_color,
                )),
            Transform.rotate(
                angle: 180 * 3.1415 / 180,
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        active = 9;
                      });
                    },
                    icon: Icon(
                      Fix_Point_Chose.border_style,
                      color: active == 9 ? active_color : default_color,
                    )))
          ],
        ),
      ],
    );
  }
}
