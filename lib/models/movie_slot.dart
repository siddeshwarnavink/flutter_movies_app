import './movie_screen.dart';

class MovieSlot {
  final String id;
  final String date;
  final String timings;
  final MovieScreen screen;

  MovieSlot({this.date, this.timings, this.screen, this.id});
}
