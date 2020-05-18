import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../models/user_booking.dart';

class UserBookingProvider with ChangeNotifier {
  final String userId;

  UserBookingProvider(this.userId, this.items);

  List<UserBooking> items = [];

  List<UserBooking> get userBookings {
    return [...items];
  }

  Future<void> placeBooking(UserBooking newBooking) async {
    var url =
        'https://cinema-ticket-bookings.firebaseio.com/users/$userId/bookings.json';

    final res = await http.post(url,
        body: jsonEncode({
          'movieId': newBooking.movieId,
          'title': newBooking.title,
          'time': newBooking.time,
          'day': newBooking.day,
          'seats': newBooking.seats,
          'seatLabel': newBooking.seatLabel
        }));

    newBooking.changeId(json.decode(res.body)['name']);

    items.add(newBooking);
    notifyListeners();
  }

  Future<void> fetchAndSetBookings() async {
    final url =
        'https://cinema-ticket-bookings.firebaseio.com/users/$userId/bookings.json';

    try {
      var res = await http.get(url);
      List<UserBooking> bookingList = [];

      var data = jsonDecode(res.body);
      data.keys.forEach((id) {
        bookingList.add(UserBooking(
            bookingId: id,
            day: data[id]['day'],
            seats: List<String>.from(data[id]['seats']),
            movieId: data[id]['movieId'],
            time: data[id]['time'],
            title: data[id]['title'],
            seatLabel: data[id]['seatLabel']));
      });

      items = bookingList;
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }
}
