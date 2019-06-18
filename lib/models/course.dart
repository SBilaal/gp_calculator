import 'dart:math';

class Course {
  final String course;
  final double score;
  final int unit;

  String get key{
    return course + Random().nextInt(100).toString();
  }

  Course({
    this.course,
    this.unit,
    this.score,
  });
}
