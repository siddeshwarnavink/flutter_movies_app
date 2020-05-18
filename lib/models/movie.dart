import './movie_category.dart';

class Movie {
  final String id;
  final String title;
  final String description;
  final double rateing;
  final String thumbnail;
  final bool isTicketAvailable;
  final MovieCategory category;
  final String cover;

  Movie(
      {this.id,
      this.title,
      this.description,
      this.rateing,
      this.isTicketAvailable,
      this.thumbnail,
      this.category, this.cover});
}
