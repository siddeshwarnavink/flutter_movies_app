import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../widgets/page/side_drawer.dart';
import '../../providers/user_booking_provider.dart';
import '../../widgets/page/loading_spinner.dart';

class UserBookingScreen extends StatefulWidget {
  static const routeName = '/user_bookings';

  @override
  _UserBookingScreenState createState() => _UserBookingScreenState();
}

class _UserBookingScreenState extends State<UserBookingScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        isLoading = true;
      });
      try {
        await Provider.of<UserBookingProvider>(context, listen: false)
            .fetchAndSetBookings();
      } catch (err) {
        // 
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  Widget _detailItemBuilder(caption, value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          caption,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookingProv = Provider.of<UserBookingProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Your bookings'),
          centerTitle: true,
        ),
        drawer: SideDrawer(),
        body: isLoading
            ? LoadingSpinner()
            : Padding(
                padding: EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: bookingProv.userBookings.length == 0
                      ? NoBookingFallback()
                      : Column(
                          children: bookingProv.userBookings.map((booking) {
                          String seats = '';
                          booking.seats
                              .forEach((seat) => seats = '$seats, $seat');
                          seats = seats.substring(1);

                          return ExpansionTileCard(
                            title: Text(booking.title),
                            subtitle: Text('${booking.day} - ${booking.time}'),
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: <Widget>[
                                      _detailItemBuilder(
                                          'Timings', booking.time),
                                      _detailItemBuilder('Date', booking.day),
                                      _detailItemBuilder(
                                          'Screen', booking.seatLabel),
                                      _detailItemBuilder('Seats', seats),
                                      QrImage(
                                        data: booking.bookingId,
                                        version: QrVersions.auto,
                                        size: 200.0,
                                      ),
                                    ],
                                  ))
                            ],
                          );
                        }).toList()),
                ),
              ));
  }
}

class NoBookingFallback extends StatelessWidget {
  const NoBookingFallback({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Icon(
            Icons.cloud_off,
            size: 75,
            color: Colors.grey,
          ),
          Text(
            'No bookings yet!',
            style:
                Theme.of(context).textTheme.title.copyWith(color: Colors.grey),
          )
        ],
      ),
    );
  }
}
