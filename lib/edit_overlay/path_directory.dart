import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/provider_lib.dart';

class Path_Directory extends ConsumerStatefulWidget {
  final id;
  const Path_Directory({super.key, required this.id});

  @override
  ConsumerState<Path_Directory> createState() => _Path_ObjectState();
}

class _Path_ObjectState extends ConsumerState<Path_Directory> {
  static const IconData mode_edit_outlined =
      IconData(0xf1d8, fontFamily: 'MaterialIcons');
  static const IconData visibility_off_outlined =
      IconData(0xf4a0, fontFamily: 'MaterialIcons');
  static const IconData visibility_outlined =
      IconData(0xf4a1, fontFamily: 'MaterialIcons');

  bool edit = false;
  bool show_path = true;

  Widget build(BuildContext context) {

    if (ref.watch(path_edit_id_provider) == widget.id) {
      setState(() {
        edit = true;
      });
    } else {
      setState(() {
        edit = false;
      });
    }

    return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: ListTile(
          title: edit == true
              ? FilledButton(
                  onPressed: () {},
                  child: Icon(mode_edit_outlined),
                )
              : OutlinedButton(
                  onPressed: () {
                    setState(() {
                      edit = true;
                      ref.read(path_edit_id_provider.notifier).set(widget.id);
                      ref.read(show_path_editor_provider.notifier).set(true);
                    });
                  },
                  child: Icon(mode_edit_outlined),
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
