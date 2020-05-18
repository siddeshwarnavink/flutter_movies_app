import 'package:flutter/material.dart';

import '../../../models/movie.dart';
import './movie_carousel_item_caption.dart';
import './movie_carousel_item_image.dart';

class MovieCarouselItem extends StatelessWidget {
  final Movie movie;

  MovieCarouselItem(this.movie, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        MovieCarouselItemImage(movie.cover),
        Positioned(
          bottom: 0,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  movie.title,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                MovieCarouselItemCaption(movie),
              ],
            ),
            color: Colors.black54,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          ),
        ),
      ],
    );
  }
}
