import 'package:flutter/rendering.dart';

class Matrix {
  static Matrix4 perspective([double weight = .001]) => Matrix4.identity()..setEntry(3, 2, weight);
}
