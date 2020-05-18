import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/movie_category.dart';
import '../models/movie.dart';

class MoviesProvider with ChangeNotifier {
  List<Movie> _items = [
    // Movie(
    //     title: 'Amazing spiderman',
    //     rateing: 4.9,
    //     isTicketAvailable: true,
    //     id: 'm1',
    //     thumbnail:
    //         'https://upload.wikimedia.org/wikipedia/en/0/02/The_Amazing_Spider-Man_theatrical_poster.jpeg',
    //     description: 'This is the story of the amazing spiderman',
    //     cover: 'https://i.ytimg.com/vi/ICAC8Yk6ZXo/maxresdefault.jpg',
    //     category: MovieCategory.Action),
    // Movie(
    //     title: 'Harry potter',
    //     rateing: 4.5,
    //     isTicketAvailable: true,
    //     id: 'm2',
    //     thumbnail:
    //         'https://irs.www.warnerbros.com/keyart-jpeg/movies/media/browser/harry_potter_8film_2000x3000.jpg',
    //     description: 'This is the story of the little boy Harry',
    //     category: MovieCategory.Thrilling,
    //     cover:
    //         'https://hips.hearstapps.com/digitalspyuk.cdnds.net/16/48/1480508469-harry-potter-in-90-minutes-1480436463.jpg'),
    // Movie(
    //     title: 'Fast and furious',
    //     rateing: 4.6,
    //     isTicketAvailable: true,
    //     id: 'm3',
    //     thumbnail:
    //         'https://upload.wikimedia.org/wikipedia/en/2/2d/The_Fate_of_The_Furious_Theatrical_Poster.jpg',
    //     description: 'This is all about raceing!',
    //     cover: 'https://i.ytimg.com/vi/1LQco5A4KNU/maxresdefault.jpg',
    //     category: MovieCategory.Thrilling),
    // Movie(
    //     title: 'Home Alone',
    //     rateing: 4.3,
    //     isTicketAvailable: true,
    //     id: 'm4',
    //     cover:
    //         'https://img.thedailybeast.com/image/upload/c_crop,d_placeholder_euli9k,h_1440,w_2560,x_0,y_0/dpr_1.5/c_limit,w_1044/fl_lossy,q_auto/v1513982397/171220-ryan-home-alone-tease_zntomw',
    //     thumbnail:
    //         'https://upload.wikimedia.org/wikipedia/en/7/76/Home_alone_poster.jpg',
    //     description: 'He is home alone!',
    //     category: MovieCategory.Comedy),
    // Movie(
    //     title: 'Johnny English',
    //     rateing: 4.6,
    //     isTicketAvailable: true,
    //     id: 'm5',
    //     thumbnail:
    //         'https://m.media-amazon.com/images/M/MV5BMjI4MjQ3MjI5MV5BMl5BanBnXkFtZTgwNjczMDE4NTM@._V1_.jpg',
    //     description: 'Really funny movie!',
    //     category: MovieCategory.Comedy,
    //     cover:
    //         'https://in.bookmyshow.com/entertainment/wp-content/uploads/2018/09/960x540_1-1.jpg'),
    // Movie(
    //     title: 'Iron Man',
    //     rateing: 4.2,
    //     isTicketAvailable: true,
    //     id: 'm6',
    //     thumbnail:
    //         'https://upload.wikimedia.org/wikipedia/en/0/00/Iron_Man_poster.jpg',
    //     description: 'The story of Icon man!',
    //     category: MovieCategory.Action,
    //     cover:
    //         'https://images.indianexpress.com/2019/04/iron-man-avengers-1200.jpeg'),
    // Movie(
    //     title: 'End game',
    //     rateing: 4.3,
    //     isTicketAvailable: true,
    //     id: 'm7',
    //     thumbnail:
    //         'https://upload.wikimedia.org/wikipedia/en/0/0d/Avengers_Endgame_poster.jpg',
    //     description: 'It is the end of the game',
    //     category: MovieCategory.Action,
    //     cover:
    //         'https://filmschoolrejects.com/wp-content/uploads/2019/08/commentary-avengers-endgame-1280x720.jpg'),
    // Movie(
    //     title: 'Anabella',
    //     rateing: 4.5,
    //     isTicketAvailable: true,
    //     id: 'm8',
    //     thumbnail:
    //         'https://lh3.googleusercontent.com/QVxRkggnOWcUs7D5c1DfHpxsl7mdfigBDgXM3LUaibIVnAaxFxW7Nf8nXC-xJrmtJzI',
    //     description: 'Very Scarry!',
    //     category: MovieCategory.Thrilling,
    //     cover:
    //         'https://filmschoolrejects.com/wp-content/uploads/2019/05/annabelle-1280x720.jpg'),
    // Movie(
    //     title: 'Curse of Chucky',
    //     rateing: 4.3,
    //     isTicketAvailable: true,
    //     id: 'm9',
    //     thumbnail:
    //         'https://upload.wikimedia.org/wikipedia/en/b/b4/Curse_of_Chucky.jpg',
    //     description: 'Very very Scarry!',
    //     category: MovieCategory.Thrilling,
    //     cover: 'https://i.ytimg.com/vi/OsocSiz54gM/maxresdefault.jpg'),
  ];

  Future<void> fetchAndSetMovies() async {
    const url = 'https://cinema-ticket-bookings.firebaseio.com/movies.json';

    var res = await http.get(url);
    List<Movie> movieList = [];

    Map<String, dynamic> data = jsonDecode(res.body);
    data.keys.forEach((id) {
      movieList.add(Movie(
        id: id,
        title: data[id]['title'],
        cover: data[id]['cover'],
        category: categoriesMap[data[id]['category'] - 1]['value'],
        description: data[id]['description'],
        isTicketAvailable: data[id]['isTicketAvailable'],
        rateing: data[id]['rateing'],
        thumbnail: data[id]['thumbnail'],
      ));
    });

    _items = movieList;
    notifyListeners();
  }

  List<Movie> get featuredMovies {
    final returnList = [..._items];
    returnList.sort((a, b) => (a.rateing < b.rateing) ? 1 : 0);
    return returnList.take(3).toList();
  }

  List<Movie> getSpecificCategories(MovieCategory cat) {
    return _items.where((movie) => movie.category == cat).toList();
  }

  Movie getSingleMovie(String id) {
    return _items.firstWhere((movie) => movie.id == id);
  }
}
