import 'package:flutter/material.dart';

class BooleanCircleIconButton extends StatelessWidget {
  static const IconData cancel_outlined =
      IconData(0xef28, fontFamily: 'MaterialIcons');
  static const IconData check_circle_outline =
      IconData(0xef47, fontFamily: 'MaterialIcons');

  final bool isActive;
  final void Function() onTap;
  final txt;
  const BooleanCircleIconButton(
      {Key? key,
      required this.isActive,
      required this.onTap,
      required this.txt})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0, left: 8),
          child: Text(
            txt,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.hardEdge,
          color: Colors.black12,
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(12.0),
              child:
                  isActive ? const Icon(check_circle_outline) : const Icon(cancel_outlined),
            ),
          ),
        ),
      ],
    );
  }
}
