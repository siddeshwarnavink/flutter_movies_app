import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/movies/movie_carousel/movie_carousel.dart';
import '../widgets/movies/movie_categories/movie_categories.dart';
import '../widgets/page/side_drawer.dart';
import '../providers/movies_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/page/loading_spinner.dart';

class MoviesOverviewScreen extends StatefulWidget {
  final BuildContext ctx;

  MoviesOverviewScreen(this.ctx);

  @override
  _MoviesOverviewScreenState createState() => _MoviesOverviewScreenState();
}

class _MoviesOverviewScreenState extends State<MoviesOverviewScreen> {
  bool init = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!init) {
      Provider.of<AuthProvider>(context, listen: false).tryAutoLogin();
      init = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Movies'),
          centerTitle: true,
        ),
        drawer: SideDrawer(),
        body: FutureBuilder(
          future: Provider.of<MoviesProvider>(context, listen: false)
              .fetchAndSetMovies(),
          builder: (ctx, moviesSnap) {
            if (moviesSnap.connectionState == ConnectionState.waiting) {
              return LoadingSpinner();
            }
            return SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MovieCarousel(),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MovieCategories(),
                ),
              ],
            ));
          },
        ));
  }
}
