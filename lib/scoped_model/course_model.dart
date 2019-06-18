import 'package:scoped_model/scoped_model.dart';
import '../models/course.dart';

class CourseModel extends Model{
  List<Course> _courses = [];
  int selectedIndex;
  double _gpValue;


  List<int> _gpValueColors = [0x0F0DEEDB, 0x0FCDDC39, 0x0FFFA500, 0x0FFA8072, 0x0FFF0000];
  List<String> _gpValueStatements = ["Excellent! Well done.", "Not bad!", "You've got to try harder", "Man... Not good.", "Failed!"];
  List<String> _remarks = ["First Class", "Second Class(Upper)", "Second Class(Lower)", "Third Class", "Fail"];

  int _gpValueColor;
  String _gpValueStatement;
  String _remark;
  Map<String, dynamic> _gpStatus = {
    "GP Value": null,
    "Remark": null,
    "Color": null,
    "Statement": null,
  };

  Map<String, dynamic> get gpStatus => Map<String, dynamic>.from(_gpStatus);

  void selectIndex(int index) {
    selectedIndex = index;
  }

  List<Course> get courses =>  List.from(_courses);

  void addCourse(Course course) {
    _courses.add(course);
  }

  void updateCourse(Course course) {
    _courses[selectedIndex] = course;
  }

  void deleteCourse() {
    _courses.removeAt(selectedIndex);
  }

  int _getGradePointEquivalent(double score) {
    if(score >= 70)
      return 5;
    else if(score >= 60)
      return 4;
    else if(score >= 50)
      return 3;
    else if(score >= 45)
      return 2;
    else
      return 1;
  }

  void calculateGp() {
    int sumOfUnit = 0;
    double sumOfProductOfCourseAndUnit = 0;

    for(int i = 0; i < courses.length; i++) {
      sumOfUnit += courses[i].unit;
    }
    for(int i = 0; i < courses.length; i++) {
      sumOfProductOfCourseAndUnit += (courses[i].unit * _getGradePointEquivalent(courses[i].score));
    }

    _gpValue = sumOfProductOfCourseAndUnit/sumOfUnit;
    _interpreteGpValue();
  }

  void _interpreteGpValue() {
    if(_gpValue >= 4.5) {
      _gpValueColor = _gpValueColors[0];
      _remark = _remarks[0];
      _gpValueStatement = _gpValueStatements[0];
    }
    else if(_gpValue >= 3.5) {
       _gpValueColor = _gpValueColors[1];
       _remark = _remarks[1];
      _gpValueStatement = _gpValueStatements[1];
    }
    else if(_gpValue >= 2.4) {
       _gpValueColor = _gpValueColors[2];
       _remark = _remarks[2];
      _gpValueStatement = _gpValueStatements[2];
    }
    else if(_gpValue >= 1.5) {
       _gpValueColor = _gpValueColors[3];
       _remark = _remarks[3];
      _gpValueStatement = _gpValueStatements[3];
    }
    else {
       _gpValueColor = _gpValueColors[4];
       _remark = _remarks[4];
      _gpValueStatement = _gpValueStatements[4];
    }

    _gpStatus["GP Value"] = _gpValue;
    _gpStatus["Remark"] = _remark;
    _gpStatus["Color"] = _gpValueColor;
    _gpStatus["Statement"] = _gpValueStatement;

  }
}