import 'package:flutter/material.dart';

import 'widgets/edit_course_widget.dart';

class CourseWidget extends StatefulWidget {
  final String course;
  final int unit;
  final double score;
  final Function addCourse;

  CourseWidget({this.course, this.unit, this.score, this.addCourse});

  @override
  _CourseWidgetState createState() => _CourseWidgetState();
}

class _CourseWidgetState extends State<CourseWidget> {
  final editCourseWidget = EditCourseWidget();

  Widget createSubject() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Text(
        widget.course,
        style: TextStyle(
            fontSize: 40, color: Colors.black87, fontWeight: FontWeight.w300),
      ),
    );
  }

  Widget createUnit(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('UNIT'),
          Container(
            width: 60,
            height: 35,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              border:
                  Border.all(color: Theme.of(context).primaryColor, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
                child: Text('${widget.unit}', style: TextStyle(fontSize: 25))),
          ),
        ],
      ),
    );
  }

  Widget createScore(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('SCORE'),
          Container(
            width: 60,
            height: 35,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              border:
                  Border.all(color: Theme.of(context).primaryColor, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
                child: Text('${widget.score}', style: TextStyle(fontSize: 25))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: createSubject(),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          createUnit(context),
          Expanded(
            child: Container(),
          ),
          createScore(context),
        ],
      ),
    );
  }
}
