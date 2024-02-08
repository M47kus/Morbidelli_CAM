
import 'dart:math';
import 'package:vector_math/vector_math_64.dart';

(Vector2, double) findCircle(double x1, double y1,
double x2, double y2,
double x3, double y3) {
  double x12 = x1 - x2;
  double x13 = x1 - x3;

  double y12 = y1 - y2;
  double y13 = y1 - y3;

  double y31 = y3 - y1;
  double y21 = y2 - y1;

  double x31 = x3 - x1;
  double x21 = x2 - x1;

  num sx13 = pow(x1, 2) - pow(x3, 2);

  num sy13 = pow(y1, 2) - pow(y3, 2);

  num sx21 = pow(x2, 2) - pow(x1, 2);

  num sy21 = pow(y2, 2) - pow(y1, 2);

  double f = ((sx13) * (x12)
      + (sy13) * (x12)
      + (sx21) * (x13)
      + (sy21) * (x13))
      / (2 * ((y31) * (x12) - (y21) * (x13)));
  double g = ((sx13) * (y12)
      + (sy13) * (y12)
      + (sx21) * (y13)
      + (sy21) * (y13))
      / (2 * ((x31) * (y12) - (x21) * (y13)));

  double c = -pow(x1, 2) - pow(y1, 2) - 2 * g * x1 - 2 * f * y1;
  double h = -g;
  double k = -f;
  double sqrOfR = h * h + k * k - c;

// r is the radius
  num r = num.parse(sqrt(sqrOfR).toStringAsFixed(5)).toDouble();

  return (Vector2(h, k), r.toDouble());
}