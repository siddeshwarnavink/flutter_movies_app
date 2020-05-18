class MovieScreen {
  final String id;
  final int row;
  final int col;
  final List<int> bookedSeats;
  final String screenLabel;

  MovieScreen(
      {this.row, this.col, this.bookedSeats, this.screenLabel, this.id});
}
