import 'package:flutter/material.dart';

import '../../../core/sqfliteServices/sqflite_services.dart';

class FavoriteMovieProvider extends ChangeNotifier {
  List<Map<String, dynamic>>? _favoriteMovie = [];

  List<Map<String, dynamic>>? get favoriteMovie => _favoriteMovie;

  set favoriteMovie(List<Map<String, dynamic>>? value) {
    _favoriteMovie = value;
    notifyListeners();
  }

  Future<void> fetchFavoriteMovie() async {
    favoriteMovie = await SqfliteServices().getData();
  }

  Future<void> addFavoriteMovie(String id, String title, String image) async {
    await SqfliteServices().insertData(id: id, title: title, image: image);
    await fetchFavoriteMovie();
  }

  Future<void> removeFavoriteMovie(String id) async {
    await SqfliteServices().deleteData(id: id);
    await fetchFavoriteMovie();
  }

  bool isFavoriteMovie(String id) {
    return favoriteMovie?.any((element) => element['id'] == id) ?? false;
  }
}
