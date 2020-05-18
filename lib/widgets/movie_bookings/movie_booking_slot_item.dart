import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/movie_slot.dart';
import '../../providers/movie_slot_provider.dart';

class MovieBookingSlotItem extends StatelessWidget {
  final MovieSlot slot;

  MovieBookingSlotItem(this.slot);

  @override
  Widget build(BuildContext context) {
    final movieSlotProv = Provider.of<MovieSlotProvider>(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: ListTile(
        leading: Radio(
            value: 1,
            groupValue: movieSlotProv.pickedSlot == slot ? 1 : 0,
            onChanged: (val) {
              movieSlotProv.pickSlot(slot);
            }),
        title: Text(slot.timings),
        subtitle: Text(
            '${slot.screen.col * slot.screen.row - slot.screen.bookedSeats.length} seats available'),
      ),
    );
  }
}
