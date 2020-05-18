class UserBooking {
  String bookingId;
  final String movieId;
  final String title;
  final String time;
  final String day;
  final List<String> seats;
  final String seatLabel;

  UserBooking(
      {this.bookingId,
      this.movieId,
      this.title,
      this.time,
      this.day,
      this.seats,
      this.seatLabel});

  void changeId(String newId) {
    this.bookingId = newId;
  }
}
