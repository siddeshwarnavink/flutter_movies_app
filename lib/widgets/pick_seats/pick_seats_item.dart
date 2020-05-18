import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/movie_slot_provider.dart';

class PickSeatsItem extends StatelessWidget {
  final int seatIndex;
  final int rowIndex;
  final int colIndex;
  final bool isAlreadyPicked;

  PickSeatsItem(
      {this.rowIndex, this.colIndex, this.isAlreadyPicked, this.seatIndex});

  Widget buildSeatItem(seatString, pickedSlot, pickedSeats) {
    return Container(
      width: 35,
      height: 30,
      child: Text(
        seatString,
        textAlign: TextAlign.center,
      ),
      padding: EdgeInsets.all(5),
      color: pickedSlot.screen.bookedSeats.contains(seatIndex)
          ? Colors.red
          : pickedSeats.contains(seatIndex) ? Colors.green : Colors.grey,
      margin: EdgeInsets.all(3),
    );
  }

  @override
  Widget build(BuildContext context) {
    final slotProv = Provider.of<MovieSlotProvider>(context);
    final pickedSlot = slotProv.pickedSlot;
    final pickedSeats = slotProv.pickedSeats;
    final seatString =
        '${String.fromCharCode(colIndex + 96).toString().toUpperCase()}${rowIndex}';

    return GestureDetector(
      onTap: pickedSlot.screen.bookedSeats.contains(seatIndex)
          ? () {}
          : () => slotProv.pickSeatToggler(seatIndex, seatString),
      child: rowIndex.remainder(5) != 0
          ? buildSeatItem(seatString, pickedSlot, pickedSeats)
          : Row(
              children: <Widget>[
                buildSeatItem(seatString, pickedSlot, pickedSeats),
                SizedBox(
                  width: 35,
                  height: 30,
                )
              ],
            ),
    );
  }
}
