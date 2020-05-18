import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/movie_category.dart';
import '../../../providers/movies_provider.dart';
import './movie_categories_slide.dart';

class MovieCategories extends StatefulWidget {
  @override
  _MovieCategoriesState createState() => _MovieCategoriesState();
}

class _MovieCategoriesState extends State<MovieCategories> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: categoriesMap.map((map) {
        final mapMovies = Provider.of<MoviesProvider>(context, listen: false)
            .getSpecificCategories(map['value']);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              map['label'],
              style: Theme.of(context).textTheme.title,
            ),
            MovieCatrgoriesSlide(
              mapMovies: mapMovies,
            )
          ],
        );
      }).toList(),
    );
  }
}
