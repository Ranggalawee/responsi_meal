import 'package:flutter/material.dart';
import 'package:responsi_meal/Pages/homepage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Meal',
    theme: ThemeData(
      primarySwatch: Colors.green,
    ),
    home: const HomePage(),
  ));
}

