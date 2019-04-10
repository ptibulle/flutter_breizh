import 'package:flutter/material.dart';
import 'package:flutter_breizh/data/place.dart';

class PlaceDetailPage extends StatelessWidget {
  PlaceDetailPage({
    Key key,
    @required this.place,
  }) : super(key: key);

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
