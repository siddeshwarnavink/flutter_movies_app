import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import './screens/movies_overview_screen.dart';
import './providers/movies_provider.dart';
import './screens/movie_detail_screen.dart';
import './screens/bookings/booking_pick_slot_screen.dart';
import './providers/movie_slot_provider.dart';
import './screens/bookings/booking_pick_seats_screen.dart';
import './screens/bookings/booking_completed.dart';
import './screens/bookings/user_booking_screen.dart';
import './providers/user_booking_provider.dart';
import './guards/auth_guard.dart';
import './providers/auth_provider.dart';
import './screens/auth_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.black));
  runApp(Phoenix(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => MoviesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => MovieSlotProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, UserBookingProvider>(
          create: (_) => UserBookingProvider('', []),
          update: (ctx, auth, prvBookingProv) =>
              UserBookingProvider(auth.userId, prvBookingProv.userBookings),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movies',
        theme: ThemeData(
            primaryColor: Colors.black,
            accentColor: Colors.yellow,
            brightness: Brightness.light,
            fontFamily: 'BalsamiqSans',
            textTheme: TextTheme(title: TextStyle(fontSize: 25)),
            appBarTheme: AppBarTheme(
                elevation: 0,
                textTheme: TextTheme(
                  title: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                      color: Colors.yellow),
                ))),
        home: MoviesOverviewScreen(context),
        routes: {
          MovieDetailScreen.routeName: (_) => MovieDetailScreen(),
          BookingPickSlotScreen.routeName: (_) =>
              AuthGuard(BookingPickSlotScreen()),
          BookingPickSeatsScreen.routeName: (_) =>
              AuthGuard(BookingPickSeatsScreen()),
          BookingCompleted.routeName: (_) => AuthGuard(BookingCompleted()),
          UserBookingScreen.routeName: (_) => AuthGuard(UserBookingScreen()),
          AuthScreen.routeName: (_) => AuthScreen(true)
        },
      ),
    );
  }
}
