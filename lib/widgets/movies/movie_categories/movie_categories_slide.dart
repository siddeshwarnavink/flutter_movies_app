import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import '../../../models/movie.dart';
import './movie_categories_item.dart';
// import './movie_categories_item.dart';
// import '../../../helpers/math.dart';
// import './movie_categories_item_caption.dart';

class MovieCatrgoriesSlide extends StatelessWidget {
  MovieCatrgoriesSlide({
    Key key,
    @required this.mapMovies,
  }) : super(key: key);

  final List<Movie> mapMovies;

//   @override
//   _MovieCatrgoriesSlideState createState() => _MovieCatrgoriesSlideState();
// }

// class _MovieCatrgoriesSlideState extends State<MovieCatrgoriesSlide> {
  // int _currentSlide = 0;

  final scrollCtl = ScrollController();

  void _onItemFocus(int index) {
    if (index == 0) {
      scrollCtl.jumpTo(70);
    }
  }

  Widget _buildListItem(BuildContext context, int index) {
    final currentMovie = mapMovies[index];

    return MovieCategoriesSlideItem(currentMovie: currentMovie);
  }

  ///Override default dynamicItemSize calculation
  // double customEquation(double distance) {
  //   // return 1-min(distance.abs()/500, 0.2);
  //   return 1 - (distance / 1000);
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      child: ScrollSnapList(
        onItemFocus: _onItemFocus,
        margin: EdgeInsets.all(0),
        listController: scrollCtl,
        initialIndex: 1,
        updateOnScroll: true,
        padding: EdgeInsets.all(0),
        itemSize: 120,
        itemBuilder: _buildListItem,
        itemCount: mapMovies.length,
        // dynamicItemSize: true,
        // dynamicSizeEquation: customEquation, //optional
      ),
    );

    // return CarouselSlider(
    //   options: CarouselOptions(
    //       enableInfiniteScroll: false,
    //       autoPlay: false,
    //       autoPlayCurve: Curves.fastOutSlowIn,
    //       viewportFraction: 1,
    //       onPageChanged: (index, reason) {
    //         setState(() {
    //           _currentSlide = index;
    //         });
    //       }),
    //   items: List(
    //           (MathHelpers.findNearestFactorFromInt(widget.mapMovies.length) /
    //                   3)
    //               .round())
    //       .map((_) {
    //     var slides = [0, 1, 2].map((index) {
    //       return Expanded(
    //         child: Builder(
    //           builder: (_) {
    //             try {
    //               final currentMovie = widget.mapMovies
    //                   .skip((_currentSlide * 3))
    //                   .take(index + 1)
    //                   .toList()[index];

    //               return MovieCategoriesItem(currentMovie);
    //             } catch (err) {
    //               return SizedBox(
    //                 height: 10,
    //               );
    //             }
    //           },
    //         ),
    //       );
    //     }).toList();

    //     return Row(
    //       children: slides,
    //     );
    //   }).toList(),
    // );
  }
}
