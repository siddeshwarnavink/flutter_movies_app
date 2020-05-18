import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/movies_provider.dart';
import '../../providers/movie_slot_provider.dart';
import '../../widgets/movie_bookings/movie_booking_detail.dart';
import '../../widgets/movie_bookings/movie_booking_slots.dart';
import '../../screens/bookings/booking_pick_seats_screen.dart';
import '../../widgets/page/loading_spinner.dart';

class BookingPickSlotScreen extends StatelessWidget {
  static String routeName = '/bookings/1';

  @override
  Widget build(BuildContext context) {
    final movieId = ModalRoute.of(context).settings.arguments as String;
    final movieSlotProv =
        Provider.of<MovieSlotProvider>(context, listen: false);
    final movieData = Provider.of<MoviesProvider>(context, listen: false)
        .getSingleMovie(movieId);

    return Scaffold(
        appBar: AppBar(
          title: Text('Choose your slot'),
        ),
        body: FutureBuilder(
          future: movieSlotProv.fetchAndSetSlots(movieId),
          builder: (ctx, movieSlotSnap) {
            if (movieSlotSnap.connectionState == ConnectionState.waiting) {
              return LoadingSpinner();
            }

            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  MovieBookingDetail(movieData),
                  Container(
                    child: Text(
                      'Available slots',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 10),
                  ),
                  MovieBookingSlots(movieData),
                  Center(
                    child: Consumer<MovieSlotProvider>(
                      builder: (ctx, prov, _) {
                        return RaisedButton(
                          color: Theme.of(context).accentColor,
                          child: Text(
                            'PICK SEAT',
                          ),
                          onPressed: prov.pickedSlot == null
                              ? null
                              : () {
                                  Navigator.of(context).pushReplacementNamed(
                                      BookingPickSeatsScreen.routeName,
                                      arguments: movieData.id);
                                },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
