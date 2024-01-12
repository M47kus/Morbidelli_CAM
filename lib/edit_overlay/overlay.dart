import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/edit_overlay/edit_window_build.dart';
import 'package:morbidelli_cam/edit_overlay/path_directory.dart';
import 'package:morbidelli_cam/edit_overlay/path_object.dart';
import '../path_privider_lib.dart';
import 'edit_mask.dart';

//Stacked editor controlls all panels for path editing
class Path_Editor extends ConsumerStatefulWidget {
  const Path_Editor({super.key});

  @override
  ConsumerState<Path_Editor> createState() => _Path_EditorState();
}

class _Path_EditorState extends ConsumerState<Path_Editor> {
  @override
  Widget build(BuildContext context) {
    List pathDirectory = ref.watch(path_directory_provider);
    return Column(
      children: [
        //if true the selection bar is shown
        Visibility(
            visible: ref.watch(show_path_editor_provider),
            child: const Path_Mask()),
        //shows all splines which are created (left side)
        Expanded(
            child: Row(
          children: [
            Expanded(
              flex: 300,
              child: Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: 300,
                  child: ListView(
                    children: [
                      //imports all splines from provider list
                      for (var item in pathDirectory) item,
                      const Create_Path_Button()
                    ],
                  ),
                ),
              ),
            ),
            //if true the main edit view is shown (replace the 3d model in middle of screen)

            Visibility(
              visible: ref.watch(show_creator_provider),
              child: Expanded(
                flex: (MediaQuery.of(context).size.width - 300 * 2).round(),
                child: Align(
                    alignment: Alignment.topCenter,
                    child: build_edit_window(ref.read(path_entity_provider)[
                            ref.watch(path_directory_id_provider)]![
                        ref.watch(path_object_id_provider)])),
              ),
            ),

            //shows the precise info from spline in left side

            Visibility(
              visible: ref.watch(show_path_editor_provider),
              child: const Expanded(
                flex: 300,
                child: Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(width: 300, child: Path_SubObject()),
                ),
              ),
            )
          ],
        ))
      ],
    );
  }
}
