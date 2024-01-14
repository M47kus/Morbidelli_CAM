import '../../load_settings.dart';

class Data {
  double? x;
  double? y;
  double? z;
  int? fix;

  convertX() {
    double dx = double.parse(modelDX.text);
    if (x != null) {
      switch (fix) {
        case 1 || 4 || 7:
          return x;
        case 2 || 5 || 8:
          return x! + dx / 2;
        case 3 || 6 || 9:
          return dx - x!;
      }
    }
  }

  convertY() {
    double dy = double.parse(modelDY.text);
    if (y != null) {
      switch (fix) {
        case 1 || 2 || 3:
          return y;
        case 4 || 5 || 6:
          return y! + dy / 2;
        case 7 || 8 || 9:
          return dy - y!;
      }
    }
  }
}
