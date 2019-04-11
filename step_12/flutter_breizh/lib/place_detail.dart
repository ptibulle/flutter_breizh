import 'package:flutter/material.dart';
import 'package:flutter_breizh/data/place.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PlaceDetailPage extends StatelessWidget {
  PlaceDetailPage({
    Key key,
    @required this.place,
  }) : super(key: key);

  final Place place;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'title_${place.numid}',
          child: Text(
            place.title,
            style: textTheme.title.copyWith(color: Colors.white),
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: place.pictures.length + 1,
        itemBuilder: (BuildContext _context, int i) {
          if (i == 0) { // Main Picture
            return Hero(
              tag: 'image_${place.numid}',
              child: CachedNetworkImage(
                placeholder: Container(
                  color: Colors.black12,
                ),
                imageUrl: place.pictures[0],
                fit: BoxFit.cover,
              ),
            );
          } else if (i == 1) { // Description
            return Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  place.description,
                  style: textTheme.subhead,
                )
            );
          } else { // Pictures
            return Padding(
              padding: const EdgeInsets.only(top: 16),
              child: CachedNetworkImage(
                      placeholder: Container(
                        color: Colors.black12,
                      ),
                      imageUrl: place.pictures[i-1],
                      fit: BoxFit.cover,
                    )
            );
          }
        }
      ),
    );
  }
}
