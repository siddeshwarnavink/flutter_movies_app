import 'package:flutter/material.dart';

import '../../../models/movie.dart';

class MovieCarouselItemCaption extends StatelessWidget {
  final Movie movie;

  MovieCarouselItemCaption(this.movie);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          movie.rateing.toString(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        Container(
          child: Icon(Icons.star, color: Colors.white, size: 12),
          margin: EdgeInsets.only(bottom: 2, left: 3),
        )
      ],
    );
  }
}
