import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../path_privider_lib.dart';

//Main Splines on left side
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

  @override
  Widget build(BuildContext context) {
    //set edit variable if own id is found in edit provider
    if (ref.watch(path_directory_id_provider) == widget.id) {
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
              //return Lined/Filled Button coresponding to edit variable
              ? FilledButton(
                  onPressed:
                      ref.watch(path_directory_lock_provider) ? null : () {},
                  child: const Icon(mode_edit_outlined),
                )
              : OutlinedButton(
                  onPressed: ref.watch(path_directory_lock_provider)
                      ? null
                      : () {
                          setState(() {
                            //set edit to true and change editing privider id
                            edit = true;
                            ref
                                .read(path_directory_id_provider.notifier)
                                .set(widget.id);
                            //show spline creaton window
                            ref
                                .read(show_path_editor_provider.notifier)
                                .set(true);
                          });
                        },
                  child: const Icon(mode_edit_outlined),
                ),
          //hide Button
          trailing: OutlinedButton(
            onPressed: ref.watch(path_directory_lock_provider)
                ? null
                : () {
                    setState(() {
                      //set show path variable
                      if (show_path == true) {
                        show_path = false;
                      } else {
                        show_path = true;
                      }
                    });
                  },
            //change icon
            child: show_path == true
                ? const Icon(visibility_outlined)
                : const Icon(visibility_off_outlined),
          ),
        ));
  }
}

//Button for spline creaton
class Create_Path_Button extends ConsumerWidget {
  const Create_Path_Button({super.key});

  static const IconData add_box_outlined =
      IconData(0xee3c, fontFamily: 'MaterialIcons');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 15, right: 22, bottom: 8),
      child: OutlinedButton(
        onPressed: ref.watch(path_directory_lock_provider)
            ? null
            : () {
                //open edit overlay
                ref.read(show_path_editor_provider.notifier).set(true);
                int newDirId = ref.read(path_directory_provider).length + 1;
                ref
                    .read(path_directory_provider.notifier)
                    .add(Path_Directory(id: newDirId));

                ref
                    .read(path_directory_id_provider.notifier)
                    .set(newDirId); //set new id as active window
                ref.read(path_entity_provider.notifier).new_directory(
                    newDirId); //create new directory in main data structure
              },
        child: const Icon(add_box_outlined),
      ),
    );
  }
}
