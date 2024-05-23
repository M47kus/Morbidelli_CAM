
import 'package:morbidelli_cam/provider/global.dart';

extension ParseInternal on String? {
  double? parseInternalVar () {
    if(this != null) {
      double state = 0.0;
      try {
        state = double.parse(this!);
      } catch (error) {
        if (globalVar.state.containsKey(this)) {
          state = globalVar.state[this]!;
        }
      }
      return state;
    } else {
      return null;
    }

  }
}