import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:gp_calculator/course_widget.dart';
import 'package:gp_calculator/scoped_model/course_model.dart';
import 'package:gp_calculator/widgets/edit_course_widget.dart';
import 'package:scoped_model/scoped_model.dart';

import 'models/course.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _key = GlobalKey<FormState>();

  final _courseController = TextEditingController();

  final _unitController = TextEditingController();

  final _scoreController = TextEditingController();

  final _hintStyle = TextStyle(fontSize: 20);

  final _formData = <String, dynamic>{
    "Course": null,
    "Unit": 0,
    "Score": 0.0,
  };

  final editCourseWidget = EditCourseWidget();

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

  void _addCourse(BuildContext context) {
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

  Widget buildCourseForm() {
    return Form(
      key: _key,
      child: Container(
        constraints: BoxConstraints(maxHeight: 170, minHeight: 140),
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (String value) {
                if (value.isEmpty || value.length > 10) {
                  return "Invalid course";
                }
              },
              controller: _courseController,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                isDense: true,
                labelText: 'Course code',
                hintText: 'Course',
                hintStyle: _hintStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    validator: (String value) {
                      if (value.isEmpty || !(num.parse(value) is int)) {
                        return "Invalid unit value";
                      }
                    },
                    controller: _unitController,
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                        isDense: true,
                        labelText: 'Unit',
                        hintText: "Unit",
                        hintStyle: _hintStyle,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                ),
                Expanded(
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    validator: (String value) {
                      if (value.isEmpty || !(num.parse(value) is num)) {
                        return "Invalid score";
                      }
                    },
                    controller: _scoreController,
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                        isDense: true,
                        labelText: 'Score',
                        hintText: "Score",
                        hintStyle: _hintStyle,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _submitForm(BuildContext context, CourseModel model) {
    if (_key.currentState.validate()) {
      _formData["Course"] = _courseController.text;
      _formData["Unit"] = int.parse(_unitController.text);
      _formData["Score"] = double.parse(_scoreController.text);
      setState(() {
        model.addCourse(Course(
          course: _formData['Course'],
          unit: _formData['Unit'],
          score: _formData['Score'],
        ));
        _key.currentState.save();
        _courseController.text = "";
        _unitController.text = "";
        _scoreController.text = "";
      });
      Navigator.of(context).pop();
    }
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
                            model.selectedIndex = null;
                          }
                        },
                        key: Key(model.courses[index].key),
                        child: CourseWidget(
                          course: model.courses[index].course,
                          unit: model.courses[index].unit,
                          score: model.courses[index].score,
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
                      onPressed: () => _addCourse(context),
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
