import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_breizh/data/place.dart';
import 'package:flutter_breizh/place_detail.dart';

/// Gets a list of places from data-tourisme API.
Future<List<Place>> getPlaces() async {
  String json;
  final response = await http.get(
      "https://api.myjson.com/bins/ybkmk");
  if (response.statusCode == 200) {
    json = utf8.decode(response.bodyBytes);
  } else {
    json = await rootBundle.loadString('assets/places.json');
  }
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

class _PlaceTile extends StatefulWidget {
  _PlaceTile({
    Key key,
    @required this.place,
  }) : super(key: key);

  final Place place;

  @override
  _PlaceTileState createState() {
    return new _PlaceTileState();
  }
}

class _PlaceTileState extends State<_PlaceTile> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 100,
        height: 56,
        child: Hero(
          tag: 'image_${widget.place.numid}',
          child: CachedNetworkImage(
            placeholder: (context, url) => Container(
              color: Colors.black12,
            ),
            imageUrl: widget.place.pictures[0],
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Hero(
        tag: 'title_${widget.place.numid}',
        child: Text(
          widget.place.title,
          style: Theme.of(context).textTheme.subhead,
        ),
      ),
      subtitle: Text(widget.place.city),
      trailing: IconButton(
        icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
        onPressed: () {
          setState(() {
            isFavorite = !isFavorite;
          });
        },
      ),
      onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PlaceDetailPage(
                    place: widget.place,
                  ),
            ),
          ),
    );
  }
}
