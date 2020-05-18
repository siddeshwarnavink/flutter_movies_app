import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import '../../screens/bookings/user_booking_screen.dart';
import '../../providers/auth_provider.dart';
import '../../screens/auth_screen.dart';

class SideDrawer extends StatelessWidget {
  Widget buildListTile(String text, IconData icon, Function buildHandler) {
    return ListTile(
      onTap: buildHandler,
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        text,
        style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 24,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 139,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Theme.of(context).accentColor,
            alignment: Alignment.centerLeft,
            child: Text(
              "Popcorns ready! ",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile("Home", Icons.home, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          Consumer<AuthProvider>(builder: (ctx, authProv, _) {
            if (authProv.isAuth) {
              return Column(
                children: <Widget>[
                  buildListTile("Bookings", Icons.confirmation_number, () {
                    Navigator.of(context)
                        .pushReplacementNamed(UserBookingScreen.routeName);
                  }),
                  buildListTile("Logout", Icons.exit_to_app, () {
                    Provider.of<AuthProvider>(context, listen: false).logout();
                    Navigator.of(context).pushReplacementNamed('/');
                    Phoenix.rebirth(context);
                  }),
                ],
              );
            } else {
              return buildListTile("Authenticate", Icons.person, () {
                Navigator.of(context)
                    .pushReplacementNamed(AuthScreen.routeName);
              });
            }
          }),
        ],
      ),
    );
  }
}
