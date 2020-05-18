import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../models/movie.dart';
import './movie_booking_slot_item.dart';
import '../../providers/movie_slot_provider.dart';

class MovieBookingSlots extends StatelessWidget {
  final Movie movieData;

  MovieBookingSlots(this.movieData);

  @override
  Widget build(BuildContext context) {
    final movieSlotProv = Provider.of<MovieSlotProvider>(context);
    final distinctSlots = movieSlotProv.distictSlotDates;

    return Container(
      height: 350,
      child: ListView(
          children: distinctSlots.map((date) {
        final dateString =
            DateFormat('dd/MM/yyyy').parse(date).toIso8601String();

        final innerSlots =
            movieSlotProv.slots.where((s) => s.date == date).toList();

        return ExpansionTileCard(
          title: Text(
              DateFormat('EEE, MMMM d').format(DateTime.parse(dateString))),
          subtitle: Text('${innerSlots.length} shows'),
          children: innerSlots.map((slot) {
            return MovieBookingSlotItem(slot);
          }).toList(),
        );
      }).toList()),
    );
  }
}
