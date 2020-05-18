import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/movies_provider.dart';
import '../widgets/movies/movie_detail/movie_detail_cover.dart';
import '../widgets/movies/movie_detail/movie_detail_caption.dart';
import '../widgets/movies/movie_detail/movie_detail_description.dart';
import '../screens/bookings/booking_pick_slot_screen.dart';

class MovieDetailScreen extends StatelessWidget {
  static const routeName = '/movie_detail';

  @override
  Widget build(BuildContext context) {
    final movieId = ModalRoute.of(context).settings.arguments as String;
    final movieData =
        Provider.of<MoviesProvider>(context).getSingleMovie(movieId);

    return Scaffold(
      appBar: AppBar(
        title: Text(movieData.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MovieDetailCover(movieData.cover),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MovieDetailCaption(movieData.title, movieData.rateing),
                  SizedBox(
                    height: 5,
                  ),
                  MovieDetailDescription(movieData.description),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Card(
        margin: EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: RaisedButton(
            color: Theme.of(context).accentColor,
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(
                  BookingPickSlotScreen.routeName,
                  arguments: movieData.id);
            },
            child: Text('Book now!'),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ),
    );
  }
}
