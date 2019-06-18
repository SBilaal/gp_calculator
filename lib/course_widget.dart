import 'package:flutter/material.dart';

import 'widgets/edit_course_widget.dart';



class CourseWidget extends StatelessWidget {
  final String course;
  final int unit;
  final double score;

  CourseWidget({this.course, this.unit, this.score});

  Widget createSubject() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Text(
        course,
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
            child: Center(child: Text('$unit', style: TextStyle(fontSize: 25))),
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
            child:
                Center(child: Text('$score', style: TextStyle(fontSize: 25))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        EditCourseWidget();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            Row(
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
          ],
        ),
      ),
    );
  }
}
