import 'package:ditredi/ditredi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/editor_functions/data_parse.dart';
import 'package:morbidelli_cam/main/load_settings.dart';
import 'package:morbidelli_cam/provider/provider_lib.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

import 'model_render.dart';

//Editor in Main Window
//Shows the 3d Modell
class Editor extends ConsumerStatefulWidget {
  const Editor({super.key});

  @override
  ConsumerState<Editor> createState() => _EditorState();
}

class _EditorState extends ConsumerState<Editor> {
  //Model view controller
  final _controller = DiTreDiController(
    rotationX: 90,
    rotationY: 0,
    light: vector.Vector3(-0.5, -0.5, 0.5),
    lightStrength: 1,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //read default object from file
      if (initShowDefaultModel) {
        ref
            .read(modelContentProvider.notifier)
            .readObject('assets/default.obj');
      } else {
        String wavefront = modelBase();
        //update model in provider
        ref.read(modelContentProvider.notifier).set(wavefront);
      }

      //set viewport to top
      ref.read(modelViewProvider.notifier).setTop();
      setState(() {}); //update
    });
  }

  //Model transform
  TransformModifier3D transformModel(snapshot) {
    return TransformModifier3D(
        Group3D(snapshot.data!),
        Matrix4.identity()
          ..translate(0.0, 0.0, 0.0)
          ..rotateZ(0)
          ..rotateX(0)
          ..translate(-0.0, 0.0, -0.0));
  }

  @override
  Widget build(BuildContext context) {
    //load Provider to variable
    String modelContents = ref.watch(modelContentProvider);
    String modelView = ref.watch(modelViewProvider);
    String modelApearance = ref.watch(modelApearanceProvider);
    Group3D modelLines = ref.read(entityProvider.notifier).toVisibleLines(ref);

    if (modelContents.isEmpty) {
      return const CircularProgressIndicator();
    }

    //load viewport to controller
    if (modelView == "Top") {
      _controller.rotationX = -90;
      _controller.rotationY = 0;
    }
    else if (modelView == "Front") {
      _controller.rotationX = 0;
      _controller.rotationY = 0;
    }
    else if (modelView == "SideRight") {
      _controller.rotationX = 0;
      _controller.rotationY = 90;
    }
    else if (modelView == "SideLeft") {
      _controller.rotationX = 0;
      _controller.rotationY = -90;
    }

    return SafeArea(
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.vertical,
        children: [
          Expanded(
            child: DiTreDiDraggable(
              rotationEnabled: true,
              scaleEnabled: true,
              controller: _controller,
              child: FutureBuilder(
                future: ObjParser().parse(modelContents),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    //return right body for selected appearance
                    if (modelApearance == "Points") {
                      return DiTreDi(
                        figures: [
                          ...transformModel(snapshot).toPoints(),
                          modelLines
                        ],
                        controller: _controller,
                      );
                    } else if (modelApearance == "Wireframe") {
                      return DiTreDi(
                        figures: [
                          ...transformModel(snapshot).toLines(),
                          modelLines
                        ],
                        controller: _controller,
                      );
                    } else {
                      return DiTreDi(
                        figures: [
                          transformModel(snapshot),
                          modelLines
                        ],
                        controller: _controller,
                      );
                    }
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
