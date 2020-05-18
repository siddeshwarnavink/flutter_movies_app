import 'package:flutter/material.dart';

class MovieDetailCover extends StatelessWidget {
  final String coverUrl;

  MovieDetailCover(this.coverUrl);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      coverUrl,
      height: 200,
      fit: BoxFit.cover,
    );
  }
}
