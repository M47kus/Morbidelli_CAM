import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/edit_overlay/helper/edit_window_build.dart';
import 'package:morbidelli_cam/edit_overlay/path_directory.dart';
import 'package:morbidelli_cam/edit_overlay/path_object.dart';
import '../path_privider_lib.dart';
import 'edit_mask.dart';

//Stacked editor controlls all panels for path editing
class PathEditor extends ConsumerStatefulWidget {
  const PathEditor({super.key});

  @override
  ConsumerState<PathEditor> createState() => _PathEditorState();
}

class _PathEditorState extends ConsumerState<PathEditor> {
  @override
  Widget build(BuildContext context) {
    Map<int, PathDirectory> pathDirectory = ref.watch(pathDirectoryProvider);
    return Column(
      children: [
        //if true the selection bar is shown
        Visibility(
            visible: ref.watch(showPathEditorProvider),
            child: const PathMask()),
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
                      for (var item in pathDirectory.values) item,
                      const CreatePathButton()
                    ],
                  ),
                ),
              ),
            ),
            //if true the main edit view is shown (replace the 3d model in middle of screen)

            Visibility(
              visible: ref.watch(showCreatorProvider),
              child: Expanded(
                flex: (MediaQuery.of(context).size.width - 300 * 2).round(),
                child: Align(
                    alignment: Alignment.topCenter,
                    child: buildEditWindow(ref.read(pathEntityProvider)[
                            ref.watch(pathDirectoryIdProvider)]![
                        ref.watch(pathObjectIdProvider)])),
              ),
            ),

            //shows the precise info from spline in left side

            Visibility(
              visible: ref.watch(showPathEditorProvider),
              child: const Expanded(
                flex: 300,
                child: Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(width: 300, child: PathSubObject()),
                ),
              ),
            )
          ],
        ))
      ],
    );
  }
}
