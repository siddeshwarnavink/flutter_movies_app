import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/movie_slot.dart';
import '../models/movie_screen.dart';

// final MovieScreen screen =
//     MovieScreen(row: 10, col: 10, bookedSeats: [20, 21, 22, 55, 56]);

class MovieSlotProvider with ChangeNotifier {
  List<MovieSlot> _items = [
    // MovieSlot(date: '18/05/2020', timings: '9am to 11am', screen: screen),
    // MovieSlot(date: '18/05/2020', timings: '2pm to 4pm', screen: screen),
    // MovieSlot(date: '18/05/2020', timings: '6pm to 8pm', screen: screen),
    // MovieSlot(date: '19/05/2020', timings: '8am to 10am', screen: screen),
    // MovieSlot(date: '19/05/2020', timings: '10am to 12pm', screen: screen),
  ];

  MovieSlot _pickedSlot;
  List<int> _pickedSeats = [];
  List<String> _pickedSeatsString = [];

  Future<void> fetchAndSetSlots(String movieId) async {
    print('movie ' + movieId);

    final url =
        'https://cinema-ticket-bookings.firebaseio.com/movieSlots/$movieId.json';

    var res = await http.get(url);

    var data = jsonDecode(res.body);

    List<MovieSlot> slotList = [];

    data.forEach((slotData) {
      slotList.add(MovieSlot(
          id: slotList.length.toString(),
          date: slotData['date'],
          timings: slotData['timings'],
          screen: MovieScreen(
              id: slotData['screen']['id'],
              screenLabel: slotData['screen']['screenLabel'],
              col: slotData['screen']['col'],
              row: slotData['screen']['row'],
              bookedSeats: slotData['screen']['bookedSeats'] == null
                  ? []
                  : List<int>.from(slotData['screen']['bookedSeats']))));
    });

    _items = slotList;
    notifyListeners();
  }

  List<String> get distictSlotDates {
    List<String> _dates = [];

    _items.forEach((slot) {
      if (!_dates.contains(slot.date)) {
        _dates.add(slot.date);
      }
    });
    return _dates;
  }

  List<MovieSlot> get slots {
    return [..._items];
  }

  void pickSlot(MovieSlot slot) {
    _pickedSlot = slot;
    notifyListeners();
  }

  MovieSlot get pickedSlot {
    return _pickedSlot;
  }

  List<int> get pickedSeats {
    return [..._pickedSeats];
  }

  List<String> get pickedSeatsString {
    return [..._pickedSeatsString];
  }

  void pickSeatToggler(int seatIndex, String seatString) {
    if (!_pickedSeats.contains(seatIndex)) {
      _pickedSeats.add(seatIndex);
      if (seatString != null) _pickedSeatsString.add(seatString);
    } else {
      // _pickedSeats.removeAt(_pickedSeats.indexOf(seatIndex));
      // _pickedSeatsString.removeAt(_pickedSeats.indexOf(seatIndex));
      _pickedSeats = _pickedSeats.where((cont) => cont != seatIndex).toList();
      _pickedSeatsString =
          _pickedSeatsString.where((cont) => cont != seatString).toList();
    }
    notifyListeners();
  }
}
