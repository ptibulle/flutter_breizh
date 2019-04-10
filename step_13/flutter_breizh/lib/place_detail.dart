import 'package:cached_network_image/cached_network_image.dart';
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
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              place.title,
              style: textTheme.title.copyWith(color: Colors.white),
            ),
            pinned: true,
            expandedHeight: 256,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  CachedNetworkImage(
                    placeholder: Container(
                      color: Colors.black12,
                    ),
                    imageUrl: place.pictures[0],
                    fit: BoxFit.cover,
                  ),
                  // This gradient ensures that the toolbar icons are distinct
                  // against the background image.
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.0, -1.0),
                        end: Alignment(0.0, -0.2),
                        colors: <Color>[Color(0x60000000), Color(0x00000000)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _SliverGroupHeader(header: 'Position'),
          _SliverBoxContent(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${place.address == '' ? '' : place.address + ', '}${place.zipCode} ${place.city}',
                  style: textTheme.title,
                ),
                Text(
                  'Latitude : ${place.latitude}',
                  style: textTheme.subtitle,
                ),
                Text(
                  'Longitude : ${place.longitude}',
                  style: textTheme.subtitle,
                ),
                SizedBox(
                  height: 8,
                ),
                AspectRatio(
                  aspectRatio: 1,
                  child: CachedNetworkImage(
                    placeholder: Container(
                      color: Colors.black12,
                    ),
                    imageUrl:
                        'https://static-maps.yandex.ru/1.x/?lang=en-US&ll=${place.longitude},${place.latitude}&z=13&l=map,sat,skl&size=450,450',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          _SliverGroupHeader(header: 'Description'),
          _SliverBoxContent(
            child: Text(
              place.description,
              style: textTheme.subhead,
            ),
          ),
          _SliverGroupHeader(header: 'Photos'),
          SliverPadding(
            padding: EdgeInsets.only(
              left: 8,
              right: 8,
              bottom: 8,
            ),
            sliver: SliverGrid.count(
              crossAxisCount: 3,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              children: place.pictures
                  .skip(1)
                  .map((picture) => CachedNetworkImage(
                        placeholder: Container(
                          color: Colors.black12,
                        ),
                        imageUrl: picture,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverGroupHeader extends StatelessWidget {
  final String header;

  _SliverGroupHeader({
    Key key,
    @required this.header,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = Theme.of(context).textTheme;
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              header,
              style: textTheme.headline,
            ),
            Padding(
              padding: EdgeInsets.only(right: 64),
              child: Container(
                height: 2,
                color: theme.accentColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _SliverBoxContent extends StatelessWidget {
  final Widget child;

  _SliverBoxContent({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      sliver: SliverToBoxAdapter(
        child: child,
      ),
    );
  }
}
