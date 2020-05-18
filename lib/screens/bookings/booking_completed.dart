import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../models/user_booking.dart';
import '../../providers/movie_slot_provider.dart';
import '../../providers/movies_provider.dart';
import './user_booking_screen.dart';
import '../../widgets/page/loading_spinner.dart';
import '../../providers/user_booking_provider.dart';

class BookingCompleted extends StatefulWidget {
  static String routeName = '/bookings/3';

  @override
  _BookingCompletedState createState() => _BookingCompletedState();
}

class _BookingCompletedState extends State<BookingCompleted> {
  var init = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final movieId = ModalRoute.of(context).settings.arguments as String;
    final movieSlotProv =
        Provider.of<MovieSlotProvider>(context, listen: false);
    final pickedSlot = movieSlotProv.pickedSlot;
    final bookedMovie = Provider.of<MoviesProvider>(context, listen: false)
        .getSingleMovie(movieId);

    if (!init) {
      final newBooking = UserBooking(
          day: pickedSlot.date,
          time: pickedSlot.timings,
          movieId: movieId,
          title: bookedMovie.title,
          seats: movieSlotProv.pickedSeatsString,
          seatLabel: pickedSlot.screen.screenLabel);

      Provider.of<UserBookingProvider>(context).placeBooking(newBooking);

      /* NOTE: THIS HAS TO BE DONE IN THE SERVER 
          NOT IN THE UI BUT IT IS DONE HERE FOR THE
          SAKE OF THE DEMO
      */
      // Reserving tickets for the user
      final url =
          'https://cinema-ticket-bookings.firebaseio.com/movieSlots/${newBooking.movieId}/${pickedSlot.id}/screen.json';

      http.patch(url,
          body: jsonEncode({'bookedSeats': movieSlotProv.pickedSeats}));

      init = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Booking completed'),
        ),
        body: FutureBuilder(
          future: Future.delayed(Duration(seconds: 2)),
          builder: (ctx , snap) {
            if(snap.connectionState == ConnectionState.waiting) {
              return LoadingSpinner();
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 16),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.highlight,
                      size: 125,
                    ),
                    Center(
                      child: Text(
                        'Your show is ready!',
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                    FlatButton(
                        child: Text('GO TO BOOKING',
                            style: TextStyle(
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold)),
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed(
                              UserBookingScreen.routeName);
                        }),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
