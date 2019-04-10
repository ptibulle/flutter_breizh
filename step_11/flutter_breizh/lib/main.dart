import 'package:flutter/material.dart';
import 'package:flutter_breizh/place_list.dart';

void main() => runApp(BreizhApp());

class BreizhApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Breizh',
      home: PlaceListPage(),
    );
  }
}
