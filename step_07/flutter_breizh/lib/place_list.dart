import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_breizh/data/place.dart';

/// Gets a list of places from data-tourisme API.
Future<List<Place>> getPlaces() async {
  String json;
  json = await rootBundle.loadString('assets/places.json');
  return placesFromJson(json);
}

class PlaceListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Breizh'),
      ),
      body: FutureBuilder<List<Place>>(
        future: getPlaces(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('An error occurred'),
            );
          } else {
            final places = snapshot.data
                .where((place) =>
                    place.pictures != null && place.pictures.length > 0)
                .toList();
            return _PlaceList(
              places: places,
            );
          }
        },
      ),
    );
  }
}

class _PlaceList extends StatelessWidget {
  _PlaceList({
    Key key,
    @required this.places,
  }) : super(key: key);

  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: places.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) => _PlaceTile(
            place: places[index],
          ),
    );
  }
}

class _PlaceTile extends StatelessWidget {
  _PlaceTile({
    Key key,
    @required this.place,
  }) : super(key: key);

  final Place place;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 100,
        height: 56,
        child: Placeholder(),
      ),
      title: Text(place.title),
      subtitle: Text(place.city),
    );
  }
}
