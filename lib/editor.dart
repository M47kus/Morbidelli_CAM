import 'dart:io';

import 'package:ditredi/ditredi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/provider_lib.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class Editor extends ConsumerStatefulWidget {
  Editor({super.key});

  @override
  ConsumerState<Editor> createState() => _EditorState();
}

class _EditorState extends ConsumerState<Editor> {
  final _controller = DiTreDiController(
    rotationX: 90,
    rotationY: 0,
    light: vector.Vector3(-0.5, -0.5, 0.5),
    lightStrength: 1,
  );

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(modelContentProvider.notifier).readObject();
      ref.read(modelViewProvider.notifier).set_Solid();
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String modelContents = ref.watch(modelContentProvider);
    String modelView = ref.watch(modelViewProvider);
    if(modelContents.isEmpty) return CircularProgressIndicator();
    if(modelView == "Top") {
      _controller.rotationX = 90;
      _controller.rotationY = 0;
    }
    if(modelView == "Front") {
      _controller.rotationX = 0;
      _controller.rotationY = 0;
    }
    if(modelView == "Side") {
      _controller.rotationX = 0;
      _controller.rotationY = 90;
    }

    return SafeArea(
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.vertical,
        children: [
          Expanded(
            child: DiTreDiDraggable(
              controller: _controller,
              child: FutureBuilder(
                future: ObjParser().parse(modelContents),
                builder: (context, snapshot) {
                   if (snapshot.hasData && snapshot.data != null) {
                    return DiTreDi(
                      figures: [TransformModifier3D(
                          Group3D(snapshot.data!),
                  Matrix4.identity()
                  ..translate(0.0, 0.0, 0.0)
                  ..rotateZ(0)
                  ..rotateX(0)
                  ..translate(-0.0, 1.0, -0.0)),

                  ],
                      controller: _controller,
                    );
                  } else {
                    return Expanded(child: CircularProgressIndicator());
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
