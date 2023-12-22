import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class Path_Object extends ConsumerStatefulWidget {
  const Path_Object({super.key});

  @override
  ConsumerState<Path_Object> createState() => _Path_ObjectState();
}

class _Path_ObjectState extends ConsumerState<Path_Object> {
  static const IconData mode_edit_outlined =
      IconData(0xf1d8, fontFamily: 'MaterialIcons');
  static const IconData visibility_off_outlined =
      IconData(0xf4a0, fontFamily: 'MaterialIcons');
  static const IconData visibility_outlined =
      IconData(0xf4a1, fontFamily: 'MaterialIcons');

  bool show_path = true;

  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: ListTile(
          title: OutlinedButton(
            onPressed: () {},
            child: const Icon(mode_edit_outlined),
          ),
          trailing: OutlinedButton(
            onPressed: () {
              setState(() {
                if (show_path == true) {
                  show_path = false;
                } else {
                  show_path = true;
                }
              });
            },
            child: show_path == true
                ? const Icon(visibility_outlined)
                : const Icon(visibility_off_outlined),
          ),
        ));
  }
}
