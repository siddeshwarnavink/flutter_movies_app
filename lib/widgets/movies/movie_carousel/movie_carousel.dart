import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import '../../../providers/movies_provider.dart';
import './movie_carousel_item.dart';
import '../../../screens/movie_detail_screen.dart';

class MovieCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          enableInfiniteScroll: false, autoPlay: true, viewportFraction: 1),
      items: Provider.of<MoviesProvider>(context, listen: false)
          .featuredMovies
          .map((movie) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              child: MovieCarouselItem(movie),
              onTap: () {
                Navigator.of(context).pushNamed(MovieDetailScreen.routeName,
                    arguments: movie.id);
              },
            );
          },
        );
      }).toList(),
    );
  }
}
