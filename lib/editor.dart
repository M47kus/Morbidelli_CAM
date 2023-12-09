import 'package:ditredi/ditredi.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'model.dart';

class Editor extends StatelessWidget {
  Editor({super.key});

  final _controller = DiTreDiController(
    rotationX: 30,
    rotationY: 30,
    light: vector.Vector3(-0.5, -0.5, 0.5),
    lightStrength: 1,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.vertical,
        children: [
          Expanded(
            child: DiTreDiDraggable(
              controller: _controller,
              child: FutureBuilder(
                future: ObjParser().loadFromResources("assets/rect.obj"),
                builder: (context, snapshot) {
                   if (snapshot.hasData && snapshot.data != null) {
                    return DiTreDi(
                      figures: snapshot.data!,
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
