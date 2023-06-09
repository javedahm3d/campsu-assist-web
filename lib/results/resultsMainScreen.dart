import 'dart:io';

import 'package:campus_assist_web/results/uploadresults.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:results_page/Cards/reusable_card.,/ dart';

class CoursePage extends StatefulWidget {
  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  // String requiredCourse = '';
  String requiredSemester = '';
  String requiredDepartment = '';

  // List revisedCourses = [
  //   {'title': 'RC 07-08', 'value': '1'},
  //   {'title': 'RC 16-17', 'value': '2'},
  //   {'title': 'RC 19-20', 'value': '3'},
  // ];
  // String defaultCourse = '';

  List departments = [
    {'title': 'Civil Engineering', 'value': '01'},
    {'title': 'Mechanical Engineering', 'value': '02'},
    {'title': 'Electrical and Electronics Engineering', 'value': '03'},
    {'title': 'Electronics and Telecommunication Engineering', 'value': '04'},
    {'title': 'Computer Engineering', 'value': '05'},
    {'title': 'Information Technology', 'value': '06'},
  ];
  String defaultDepartment = '';

  List semester = [
    {'title': 'Semester 1', 'value': '01'},
    {'title': 'Semester 2', 'value': '02'},
    {'title': 'Semester 3', 'value': '03'},
    {'title': 'Semester 4', 'value': '04'},
    {'title': 'Semester 5', 'value': '05'},
    {'title': 'Semester 6', 'value': '06'},
    {'title': 'Semester 7', 'value': '07'},
    {'title': 'Semester 8', 'value': '08'},
  ];
  String defaultSemester = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Results')),
      ),
      body: SafeArea(
        child: Expanded(
          child: Container(
            // width: double.infinity,
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //       image: AssetImage('lib/images/doodle_bg.png'),
            //       fit: BoxFit.cover),
            //   color: Colors.white,
            // ),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Container(
                        width: 200,
                        height: 200,
                        child: Image(
                            image: AssetImage('lib/images/results_logo.png'))),
                    SizedBox(
                      height: 20,
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(15),
                    //     //shape: BoxShape.circle,
                    //     color: Colors.orangeAccent,
                    //   ),
                    //   child: InputDecorator(
                    //     decoration: InputDecoration(
                    //       border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(15.0)),
                    //       contentPadding: const EdgeInsets.all(10),
                    //     ),
                    //     child: DropdownButtonHideUnderline(
                    //       child: DropdownButton<String>(
                    //           dropdownColor: Colors.orangeAccent[200],
                    //           isDense: true,
                    //           value: defaultCourse,
                    //           isExpanded: true,
                    //           menuMaxHeight: 350,
                    //           items: [
                    //             const DropdownMenuItem(
                    //               child: Text('Select Revised Course'),
                    //               value: "",
                    //             ),
                    //             ...revisedCourses
                    //                 .map<DropdownMenuItem<String>>((e) {
                    //               return DropdownMenuItem(
                    //                   child: Text(e['title']),
                    //                   value: e['value']);
                    //             }).toList(),
                    //           ],
                    //           onChanged: (courseValue) {
                    //             defaultCourse = courseValue!;
                    //             requiredCourse = defaultCourse;
                    //             print(requiredCourse);
                    //             requiredCourse =
                    //                 requiredCourse.replaceAll('1', 'RC 07-08');
                    //             requiredCourse =
                    //                 requiredCourse.replaceAll('2', 'RC 16-17');
                    //             requiredCourse =
                    //                 requiredCourse.replaceAll('3', 'RC 19-20');
                    //             print(requiredCourse);

                    //             //print('selected value $value');
                    //           }),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        //shape: BoxShape.circle,
                        color: Colors.orangeAccent,
                      ),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          contentPadding: const EdgeInsets.all(10),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                              dropdownColor: Colors.orangeAccent[200],
                              isDense: true,
                              value: defaultDepartment,
                              isExpanded: true,
                              menuMaxHeight: 350,
                              items: [
                                const DropdownMenuItem(
                                  child: Text('Select Department'),
                                  value: "",
                                ),
                                ...departments
                                    .map<DropdownMenuItem<String>>((e) {
                                  return DropdownMenuItem(
                                      child: Text(e['title']),
                                      value: e['value']);
                                }).toList(),
                              ],
                              onChanged: (deptValue) {
                                setState(() {
                                  defaultDepartment = deptValue!;
                                  requiredDepartment = defaultDepartment;
                                  requiredDepartment = requiredDepartment
                                      .replaceAll('01', 'Civil Engineering');
                                  requiredDepartment =
                                      requiredDepartment.replaceAll(
                                          '02', 'Mechanical Engineering');
                                  requiredDepartment =
                                      requiredDepartment.replaceAll('03',
                                          'Electrical and Electronics Engineering');
                                  requiredDepartment =
                                      requiredDepartment.replaceAll('04',
                                          'Electronics and Telecommunication Engineering');
                                  requiredDepartment = requiredDepartment
                                      .replaceAll('05', 'Computer Engineering');
                                  requiredDepartment =
                                      requiredDepartment.replaceAll(
                                          '06', 'Information Technology');
                                });
                                //print('selected value $value');
                              }),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        //shape: BoxShape.circle,
                        color: Colors.orangeAccent,
                      ),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          contentPadding: const EdgeInsets.all(10),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                              dropdownColor: Colors.orangeAccent[200],
                              isDense: true,
                              value: defaultSemester,
                              isExpanded: true,
                              menuMaxHeight: 350,
                              items: [
                                const DropdownMenuItem(
                                  child: Text('Select Semester'),
                                  value: "",
                                ),
                                ...semester.map<DropdownMenuItem<String>>((e) {
                                  return DropdownMenuItem(
                                      child: Text(e['title']),
                                      value: e['value']);
                                }).toList(),
                              ],
                              onChanged: (semValue) {
                                setState(() {
                                  defaultSemester = semValue!;
                                  requiredSemester = defaultSemester;
                                  requiredSemester = requiredSemester
                                      .replaceAll('01', 'Semester 1');
                                  requiredSemester = requiredSemester
                                      .replaceAll('02', 'Semester 2');
                                  requiredSemester = requiredSemester
                                      .replaceAll('03', 'Semester 3');
                                  requiredSemester = requiredSemester
                                      .replaceAll('04', 'Semester 4');
                                  requiredSemester = requiredSemester
                                      .replaceAll('05', 'Semester 5');
                                  requiredSemester = requiredSemester
                                      .replaceAll('06', 'Semester 6');
                                });
                                //print('selected value $value');
                              }),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (defaultDepartment == '' || defaultSemester == ''
                            // ||
                            // defaultCourse == ''
                            ) {
                          fillContents(context);
                        } else {
                          // FirebaseFirestore.instance
                          //     .collection(defaultCourse)
                          //     .doc(defaultDepartment)
                          //     .collection(defaultSemester)
                          //     .doc('result')
                          //     .set({'file': 'link'});

                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UploadResult(
                              // course: requiredCourse,
                              department: requiredDepartment,
                              sem: requiredSemester,
                            ),
                          ));
                        }
                      },
                      child: Text('continue'),
                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void fillContents(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text(
        "Error",
        style: TextStyle(color: Colors.black87),
      ),
      content: Text(
        "Please select all details",
        style: TextStyle(color: Colors.black87),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(primary: Colors.orange),
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    showDialog(
        context: context, builder: (BuildContext context) => alertDialog);
  }
}
