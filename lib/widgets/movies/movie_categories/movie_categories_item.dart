import 'package:flutter/material.dart';

import '../../../models/movie.dart';
import './movie_categories_item_thumbnail.dart';
import './movie_categories_item_caption.dart';
import '../../../screens/movie_detail_screen.dart';

class MovieCategoriesSlideItem extends StatelessWidget {
  const MovieCategoriesSlideItem({
    Key key,
    @required this.currentMovie,
  }) : super(key: key);

  final Movie currentMovie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(MovieDetailScreen.routeName, arguments: currentMovie.id),
      child: Container(
        width: 125,
        margin: EdgeInsets.only(right: 10),
        child: Column(
          children: <Widget>[
            MovieCategoriesItemThumbnail(currentMovie.thumbnail),
            MovieCategoriesItemCaption(currentMovie.title)
          ],
        ),
      ),
    );
  }
}
