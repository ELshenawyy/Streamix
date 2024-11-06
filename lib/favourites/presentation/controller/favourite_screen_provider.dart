import 'package:flutter/material.dart';
import '../../../core/sqfliteServices/sqflite_services.dart';

class FavoriteMovieProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _favoriteMovie = []; // Start with an empty list

  List<Map<String, dynamic>> get favoriteMovie => _favoriteMovie;

  Future<void> fetchFavoriteMovie() async {
    _favoriteMovie = await SqfliteServices().getData();
    notifyListeners(); // Notify after fetching data
  }

  Future<void> addFavoriteMovie(String id, String title, String image) async {
    await SqfliteServices().insertData(id: id, title: title, image: image);
    // Update the list in memory after adding
    await fetchFavoriteMovie();
  }

  Future<void> removeFavoriteMovie(String id) async {
    await SqfliteServices().deleteData(id: id);
    // Update the list in memory after removing
    await fetchFavoriteMovie();
  }

  bool isFavoriteMovie(String id) {
    return _favoriteMovie.any((element) => element['id'] == id);
  }
}
