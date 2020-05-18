import 'package:flutter/material.dart';

class MovieDetailCaption extends StatelessWidget {
  final String title;
  final double rateing;

  MovieDetailCaption(this.title, this.rateing);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: Theme.of(context).textTheme.title,
        ),
        Row(
          children: <Widget>[
            Icon(Icons.star),
            Text(rateing.toString()),
          ],
        ),
      ],
    );
  }
}
