import 'package:flutter/material.dart';
import 'package:bidirectional_scroll_view/bidirectional_scroll_view.dart';
import 'package:provider/provider.dart';

import '../../helpers/math.dart';
import '../../widgets/pick_seats/pick_seats_item.dart';
import '../../providers/movie_slot_provider.dart';
import '../../models/movie_slot.dart';
import './booking_completed.dart';

class BookingPickSeatsScreen extends StatelessWidget {
  static String routeName = '/bookings/2';

  List<Widget> buildPickableCol(MovieSlot pickedSlot) {
    List<Widget> returnScreens = [];
    for (var i = 1; i <= pickedSlot.screen.col; i++) {
      returnScreens.add(Row(
        children: buildPickableRow(pickedSlot, i),
      ));
    }
    return returnScreens;
  }

  List<Widget> buildPickableRow(MovieSlot pickedSlot, int col) {
    List<Widget> returnScreens = [];
    for (var i = 1; i <= pickedSlot.screen.col; i++) {
      returnScreens.add(PickSeatsItem(
        seatIndex: MathHelpers.convertRowColToIndex(
            i, col, pickedSlot.screen.row, pickedSlot.screen.col),
        rowIndex: i,
        colIndex: col,
        isAlreadyPicked: pickedSlot.screen.bookedSeats.contains(col),
      ));
    }
    return returnScreens;
  }

  @override
  Widget build(BuildContext context) {
    final moveSlotProv = Provider.of<MovieSlotProvider>(context);
    final pickedSlot = moveSlotProv.pickedSlot;
    final movieId = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pick your seats'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.done),
              onPressed: moveSlotProv.pickedSeats.length > 0
                  ? () {
                      Navigator.of(context).pushReplacementNamed(
                          BookingCompleted.routeName,
                          arguments: movieId);
                    }
                  : null)
        ],
      ),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: BidirectionalScrollViewPlugin(
              scrollDirection: ScrollDirection.both,
              child: Column(children: [
                Container(
                  child: Text('SCREEN', textAlign: TextAlign.center,),
                  width: (35 * pickedSlot.screen.col).toDouble(),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(border: Border.all(width: 3,)),
                ),
                SizedBox(height: 10,),
                ...buildPickableCol(pickedSlot)
              ])),
        ),
      ),
    );
  }
}
