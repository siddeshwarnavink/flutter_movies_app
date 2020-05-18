import 'package:flutter/material.dart';

class MovieCategoriesItemCaption extends StatelessWidget {
  final String displayTitle;

  MovieCategoriesItemCaption(this.displayTitle);

  @override
  Widget build(BuildContext context) {
    // return GridTileBar(
    //   backgroundColor: Colors.black87,
    //   title: Text(
    //     displayTitle,
    //     maxLines: 2,
    //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    //     overflow: TextOverflow.ellipsis,
    //     textAlign: TextAlign.center,
    //   ),
    // );

    return GridTileBar(
      backgroundColor: Colors.black87,
      title: Text(displayTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
    );
  }
}
