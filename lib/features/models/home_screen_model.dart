import 'package:flutter/material.dart';

class HomeScreenModel {
  final String name;
  final int age;
  final String courses;
  final VoidCallback? onPress;

  HomeScreenModel({
    required this.name,
    required this.age,
    required this.courses,
    this.onPress,
  });

  static List<HomeScreenModel> list = [
    HomeScreenModel(
      name: "Rahul",
      age: 21,
      courses: "Java",
    ),
    HomeScreenModel(
      name: "Mohit",
      age: 22,
      courses: "Flutter",
    ),
    HomeScreenModel(
      name: "Deepu",
      age: 25,
      courses: "Python",
    ),
    HomeScreenModel(
      name: "OM Babu",
      age: 18,
      courses: "Full Stck",
    ),
    HomeScreenModel(
      name: "Sangam",
      age: 20,
      courses: "C ++",
    ),
  ];
}