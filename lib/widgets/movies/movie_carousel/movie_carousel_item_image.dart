import 'package:flutter/material.dart';

class MovieCarouselItemImage extends StatelessWidget {
  final String coverUrl;

  MovieCarouselItemImage(this.coverUrl);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      coverUrl,
      fit: BoxFit.cover,
    );
  }
}
