import 'package:flutter/material.dart';
import 'package:instagram_stories/screens/home/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Stories',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
