import 'package:flutter/material.dart';

import '../../models/movie.dart';

class MovieBookingDetailCaption extends StatelessWidget {
  const MovieBookingDetailCaption({
    Key key,
    @required this.isLandscape,
    @required this.movieData,
  }) : super(key: key);

  final bool isLandscape;
  final Movie movieData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: !isLandscape ? 160 : null,
            child: Text(
              movieData.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Icon(Icons.star),
              Text(
                movieData.rateing.toString(),
              ),
            ],
          ),
          Container(
            width: !isLandscape ? 160 : null,
            child: Text(
              movieData.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
