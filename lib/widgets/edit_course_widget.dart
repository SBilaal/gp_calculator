import 'package:flutter/material.dart';
import 'package:gp_calculator/models/course.dart';
import 'package:gp_calculator/scoped_model/course_model.dart';
import 'package:scoped_model/scoped_model.dart';

class EditCourseWidget extends StatefulWidget {
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

  void submitForm(BuildContext context, CourseModel model) {
    if (_key.currentState.validate()) {
      _formData["Course"] = _courseController.text;
      _formData["Unit"] = int.parse(_unitController.text);
      _formData["Score"] = double.parse(_scoreController.text);

      model.addCourse(Course(
        course: _formData['Course'],
        unit: _formData['Unit'],
        score: _formData['Score'],
      ));

      _key.currentState.save();
      _courseController.text = "";
      _unitController.text = "";
      _scoreController.text = "";
      
      Navigator.of(context).pop();
    }
  }

  @override
  _EditCourseWidgetState createState() => _EditCourseWidgetState();
}

class _EditCourseWidgetState extends State<EditCourseWidget> {
  Widget buildCourseForm(CourseModel model) {
    // if(model.selectedIndex != null) {
    //   widget._courseController.text = model.courses[model.selectedIndex].course;
    //   widget._unitController.text = model.courses[model.selectedIndex].unit.toString();
    //   widget._scoreController.text = model.courses[model.selectedIndex].score.toString();
    //   model.selectedIndex = null;
    // }
    return Form(
      key: widget._key,
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
              controller: widget._courseController,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                isDense: true,
                labelText: 'Course code',
                hintText: 'Course',
                hintStyle: widget._hintStyle,
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
                    controller: widget._unitController,
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                        isDense: true,
                        labelText: 'Unit',
                        hintText: "Unit",
                        hintStyle: widget._hintStyle,
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
                    controller: widget._scoreController,
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                        isDense: true,
                        labelText: 'Score',
                        hintText: "Score",
                        hintStyle: widget._hintStyle,
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

  void submitForm(BuildContext context, CourseModel model) {
    if (widget._key.currentState.validate()) {
      widget._formData["Course"] = widget._courseController.text;
      widget._formData["Unit"] = int.parse(widget._unitController.text);
      widget._formData["Score"] = double.parse(widget._scoreController.text);
      setState(() {
        model.addCourse(Course(
          course: widget._formData['Course'],
          unit: widget._formData['Unit'],
          score: widget._formData['Score'],
        ));
        widget._key.currentState.save();
        widget._courseController.text = "";
        widget._unitController.text = "";
        widget._scoreController.text = "";
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, CourseModel model) {
        return buildCourseForm(model);
      },
    );
  }
}
