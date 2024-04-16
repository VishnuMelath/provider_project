import 'package:flutter/material.dart';

import '../data_model/student_model.dart';
import '../database/dbservices.dart';

class StudentProvider extends ChangeNotifier {
  var students = [];
  bool isloading = true;
  Future getAllStudent() async {
    students = [...await StudentServices().getAllStudent()];
    isloading = false;
    notifyListeners();
  }

  Future insert(Student student) async {
    await StudentServices().insert(student);
    await getAllStudent();
  }

  Future delete(Student student) async {
    await StudentServices().delete(student.key);
    await getAllStudent();
  }

  Future updateStudent(Student student, int key) async {
    await StudentServices().updateStudent(student, key);
    await getAllStudent();
  }

  Future search(searchValue) async {
    isloading = true;
    students = [...await StudentServices().search(searchValue)];
    isloading = false;
    notifyListeners();
  }
}
