import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:gp_calculator/course_widget.dart';
import 'package:gp_calculator/scoped_model/course_model.dart';
import 'package:gp_calculator/widgets/edit_course_widget.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final addCourseWidget = EditCourseWidget();

  Widget buildGPStatusDisplay(CourseModel model) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: 170.0,
            width: 170.0,
            alignment: Alignment.center,
            child: Text(
              model.gpStatus["GP Value"].toStringAsFixed(2),
              style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
                color: Color(model.gpStatus["Color"] + 0xF0000000),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(model.gpStatus["Color"]),
                  spreadRadius: 20.0,
                ),
              ],
            ),
          ),
          // SizedBox(
          //   height: 20,
          // ),
          // Text(
          //   model.gpStatus["Statement"],
          //   style: TextStyle(
          //     fontWeight: FontWeight.bold,
          //     fontSize: 25,
          //   ),
          // )
        ],
      ),
    );
  }

  void _addCourse(BuildContext context, EditCourseWidget editCourseWidget) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return ScopedModelDescendant(
          builder: (BuildContext context, Widget child, CourseModel model) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Text(
                'Enter course details.',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              content: editCourseWidget,
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'CANCEL',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Theme.of(context).primaryColor),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      editCourseWidget.submitForm(context, model);
                      model.selectIndex(null);
                    });
                  },
                  child: Text(
                    'ADD',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void showGp(BuildContext context, CourseModel model) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            model.gpStatus["Remark"],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          content: buildGPStatusDisplay(model),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'DISMISS',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Theme.of(context).primaryColor),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, CourseModel model) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'GP Planner',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w300, fontSize: 30),
          ),
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Stack(
          children: <Widget>[
            model.courses.isEmpty
                ? Center(
                    child: Text(
                      'Input your course details.',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: model.courses.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                        background: Container(
                          color: Colors.red,
                        ),
                        onDismissed: (DismissDirection direction) {
                          if (direction == DismissDirection.startToEnd) {
                            model.selectIndex(index);
                            setState(() {
                              model.deleteCourse();
                            });
                            model.selectIndex(null);
                          }
                        },
                        key: Key(model.courses[index].key),
                        child: GestureDetector(
                          onLongPress: () {
                            print('read ya!');
                            model.selectIndex(index);
                            _addCourse(context, addCourseWidget);
                          },
                          child: CourseWidget(
                            addCourse: _addCourse,
                            course: model.courses[index].course,
                            unit: model.courses[index].unit,
                            score: model.courses[index].score,
                          ),
                        ),
                      );
                    },
                  ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: () => _addCourse(context, addCourseWidget),
                      child: Icon(Icons.add),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    FloatingActionButton.extended(
                      onPressed: () {
                        if (model.courses.isNotEmpty) {
                          model.calculateGp();
                          showGp(context, model);
                        }
                      },
                      icon: Icon(Icons.sync),
                      backgroundColor: Theme.of(context).primaryColor,
                      label: Text('Calculate'),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
