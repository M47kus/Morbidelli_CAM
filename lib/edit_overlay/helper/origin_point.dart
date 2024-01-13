import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FixPointChose extends ConsumerStatefulWidget {
  final int intialactive;
  final Function returnstate;
  const FixPointChose(this.intialactive, this.returnstate, {super.key});

  static const IconData borderstyle =
      IconData(0xe100, fontFamily: 'MaterialIcons');
  static const IconData bordertop =
      IconData(0xe101, fontFamily: 'MaterialIcons');
  static const IconData borderright =
      IconData(0xe0ff, fontFamily: 'MaterialIcons');
  static const IconData borderleft =
      IconData(0xe0fd, fontFamily: 'MaterialIcons');
  static const IconData borderbottom =
      IconData(0xe0f8, fontFamily: 'MaterialIcons');
  static const IconData borderclear =
      IconData(0xe0f9, fontFamily: 'MaterialIcons');

  @override
  ConsumerState<FixPointChose> createState() => _FixPointChoseState();
}

class _FixPointChoseState extends ConsumerState<FixPointChose> {
  final Color activecolor = Colors.red;
  final Color defaultcolor = Colors.white;

  int active = 1;

  Widget getIcon(index) {
    switch (index) {
      case 2:
        return Icon(
          FixPointChose.bordertop,
          color: active == index ? activecolor : defaultcolor,
        );
      case 3:
        return Transform.rotate(
            angle: 90 * 3.1415 / 180,
            child: Icon(
              FixPointChose.borderstyle,
              color: active == index ? activecolor : defaultcolor,
            ));
      case 4:
        return Icon(
          FixPointChose.borderleft,
          color: active == 4 ? activecolor : defaultcolor,
        );
      case 5:
        return Icon(
          FixPointChose.borderclear,
          color: active == 5 ? activecolor : defaultcolor,
        );
      case 6:
        return Icon(
          FixPointChose.borderright,
          color: active == 6 ? activecolor : defaultcolor,
        );
      case 7:
        return Transform.rotate(
            angle: 270 * 3.1415 / 180,
            child: Icon(
              FixPointChose.borderstyle,
              color: active == 7 ? activecolor : defaultcolor,
            ));
      case 8:
        return Icon(
          FixPointChose.borderbottom,
          color: active == 8 ? activecolor : defaultcolor,
        );
      case 9:
        return Transform.rotate(
            angle: 180 * 3.1415 / 180,
            child: Icon(
              FixPointChose.borderstyle,
              color: active == 9 ? activecolor : defaultcolor,
            ));
      default:
        return Icon(
          FixPointChose.borderstyle,
          color: active == index ? activecolor : defaultcolor,
        );
    }
  }

  Widget getButton(index) {
    return IconButton(
        onPressed: () {
          setState(() {
            setActive(index);
          });
        },
        icon: getIcon(index));
  }

  void setActive(state) {
    setState(() {
      active = state;
      widget.returnstate(state);
    });
  }

  void _init() {
    setState(() {
      active = widget.intialactive;
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void didUpdateWidget(FixPointChose oldWidget) {
    super.didUpdateWidget(oldWidget);
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [for (int index = 1; index <= 3; index++) getButton(index)],
        ),
        Row(
          children: [for (int index = 4; index <= 6; index++) getButton(index)],
        ),
        Row(
          children: [for (int index = 7; index <= 9; index++) getButton(index)],
        ),
      ],
    );
  }
}
