import 'package:flutter/material.dart';

class PlaceListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Breizh'),
      ),
      body: _PlaceList(),
    );
  }
}

class _PlaceList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 200,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) => Text('$index'),
    );
  }
}
