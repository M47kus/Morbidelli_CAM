import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/provider_lib.dart';

class Fix_Point_Chose extends ConsumerStatefulWidget {
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
  ConsumerState<Fix_Point_Chose> createState() => _Fix_Point_ChoseState();
}

class _Fix_Point_ChoseState extends ConsumerState<Fix_Point_Chose> {
  final Color active_color = Colors.red;
  final Color default_color = Colors.white;

  @override
  void initState() {
    super.initState();
    ref.refresh(fix_point_provider);
  }

  @override
  Widget build(BuildContext context) {
    Fix_Point_Notifier active = ref.read(fix_point_provider.notifier);
    int activeRead = ref.watch(fix_point_provider);

    if (widget.intial_active != null) {
      active.set(widget.intial_active!);
    }

    return Column(
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    active.set(1);
                  });
                },
                icon: Icon(
                  Fix_Point_Chose.border_style,
                  color: activeRead == 1 ? active_color : default_color,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    active.set(2);
                  });
                },
                icon: Icon(
                  Fix_Point_Chose.border_top,
                  color: activeRead == 2 ? active_color : default_color,
                )),
            Transform.rotate(
                angle: 90 * 3.1415 / 180,
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        active.set(3);
                      });
                    },
                    icon: Icon(
                      Fix_Point_Chose.border_style,
                      color: activeRead == 3 ? active_color : default_color,
                    )))
          ],
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    active.set(4);
                  });
                },
                icon: Icon(
                  Fix_Point_Chose.border_left,
                  color: activeRead == 4 ? active_color : default_color,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    active.set(5);
                  });
                },
                icon: Icon(
                  Fix_Point_Chose.border_clear,
                  color: activeRead == 5 ? active_color : default_color,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    active.set(6);
                  });
                },
                icon: Icon(
                  Fix_Point_Chose.border_right,
                  color: activeRead == 6 ? active_color : default_color,
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
                        active.set(7);
                      });
                    },
                    icon: Icon(
                      Fix_Point_Chose.border_style,
                      color: activeRead == 7 ? active_color : default_color,
                    ))),
            IconButton(
                onPressed: () {
                  setState(() {
                    active.set(8);
                  });
                },
                icon: Icon(
                  Fix_Point_Chose.border_bottom,
                  color: activeRead == 8 ? active_color : default_color,
                )),
            Transform.rotate(
                angle: 180 * 3.1415 / 180,
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        active.set(9);
                      });
                    },
                    icon: Icon(
                      Fix_Point_Chose.border_style,
                      color: activeRead == 9 ? active_color : default_color,
                    )))
          ],
        ),
      ],
    );
  }
}
