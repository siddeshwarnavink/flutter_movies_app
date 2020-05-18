import 'package:flutter/material.dart';

class MovieCategoriesItemThumbnail extends StatelessWidget {
  final String thumbnail;

  MovieCategoriesItemThumbnail(this.thumbnail);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(
        thumbnail,
        fit: BoxFit.cover,
        height: 200,
      ),
    );
  }
}
