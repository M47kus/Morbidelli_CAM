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
    userScale: 3,
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

  dynamic transformView(transformModel, modelApearance) {
    switch (modelApearance) {
      case ModelApearance.points:
        return transformModel.toPoints();
      case ModelApearance.wire:
        return transformModel.toLines();
      default:
        return [transformModel];
    }
  }

  @override
  Widget build(BuildContext context) {
    //load Provider to variable
    String modelContents = ref.watch(modelContentProvider);
    ModelView modelView = ref.watch(modelViewProvider);
    ModelApearance modelApearance = ref.watch(modelApearanceProvider);
    LineAxis axis = LineAxis.f;

    if (modelContents.isEmpty) {
      return const CircularProgressIndicator();
    }

    //load viewport to controller
    switch (modelView) {
      case ModelView.front:
        _controller.rotationX = 0;
        _controller.rotationY = 0;
        axis = LineAxis.y;

      case ModelView.sideRight:
        _controller.rotationX = 0;
        _controller.rotationY = 90;
        axis = LineAxis.xr;

      case ModelView.sideLeft:
        _controller.rotationX = 0;
        _controller.rotationY = -90;
        axis = LineAxis.x;

      case ModelView.free:
        // _controller.rotationX = -45;
        // _controller.rotationY = 45;
        axis = LineAxis.f;

      default:
        _controller.rotationX = -90;
        _controller.rotationY = 0;
        axis = LineAxis.z;
    }

    Group3D modelLines =
        ref.read(entityProvider.notifier).parseLine3D(ref, axis);

    return SafeArea(
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.vertical,
        children: [
          Expanded(
            child: DiTreDiDraggable(
              rotationEnabled:
                  ref.read(modelViewProvider) == ModelView.free ? true : false,
              scaleEnabled: true,
              controller: _controller,
              child: FutureBuilder(
                future: ObjParser().parse(modelContents),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    //return right body for selected appearance
                    return DiTreDi(
                      figures: [
                        ...transformView(
                            transformModel(snapshot), modelApearance),
                        modelLines
                      ],
                      controller: _controller,
                    );
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
