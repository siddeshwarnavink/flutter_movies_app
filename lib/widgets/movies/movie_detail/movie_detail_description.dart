import 'package:flutter/material.dart';

class MovieDetailDescription extends StatelessWidget {
  final String description;

  MovieDetailDescription(this.description);

  @override
  Widget build(BuildContext context) {
    return Text(description);
  }
}
