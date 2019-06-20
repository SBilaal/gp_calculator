import 'package:flutter/material.dart';
import 'package:gp_calculator/homepage.dart';
import 'package:gp_calculator/scoped_model/course_model.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  bool isGood = true;
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: CourseModel(),
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'CircularStd-Book',
          primaryColor: Colors.deepOrange,
        ),
        home: HomePage(),
      ),
    );
  }
}
