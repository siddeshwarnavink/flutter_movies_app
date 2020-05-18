import 'package:flutter/material.dart';

import '../../models/movie.dart';
import './movie_booking_detail_caption.dart';

class MovieBookingDetail extends StatelessWidget {
  final Movie movieData;

  MovieBookingDetail(this.movieData);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    return Container(
      height: 200,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(
                movieData.thumbnail,
                height: 200,
              ),
              MovieBookingDetailCaption(isLandscape: isLandscape, movieData: movieData)
            ],
          ),
        ),
      ),
    );
  }
}